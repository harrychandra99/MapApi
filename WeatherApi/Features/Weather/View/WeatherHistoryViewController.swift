//
//  SavedDataController.swift
//  WeatherApi
//
//  Created by Kalvin on 06/05/26.
//

import UIKit
import SwiftData
import Combine

final class WeatherHistoryViewController: UIViewController {
    
    private var presenter: WeatherHistoryPresenter?
    private let state = WeatherHistoryState()
    private var cancellables = Set<AnyCancellable>()
    
    private var savedDays: [WeatherDayEntity] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let refreshControl = UIRefreshControl()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    private let emptyStateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMVP()
        bindState()
        
        presenter?.loadAllHistory()
    }
    
}

extension WeatherHistoryViewController{
    private func setupMVP() {
        presenter = WeatherHistoryPresenter(view: state)
    }
    
    private func setupUI() {
        title = "History"
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(closeHistoryPage)
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 110
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        
        tableView.register(WeatherItemCell.self, forCellReuseIdentifier: WeatherItemCell.identifier)
        tableView.register(WeatherDayHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherDayHeaderView.identifier)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .systemBlue
        
        emptyStateLabel.font = .systemFont(ofSize: 16, weight: .bold)
        emptyStateLabel.textColor = .systemGray
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.isHidden = true
        
        [tableView, loadingIndicator, emptyStateLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension WeatherHistoryViewController {
    private func bindState() {
        
        state.$currentState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.handleStateChange(newState)
            }
            .store(in: &cancellables)
    }
    
    private func handleStateChange(_ newState: WeatherHistoryState.State) {
        switch newState {
        case .idle:
            loadingIndicator.stopAnimating()
            emptyStateLabel.isHidden = true
            tableView.isHidden = false
            
        case .loading:
            loadingIndicator.startAnimating()
            emptyStateLabel.isHidden = true
            tableView.isHidden = true
            
        case .success(let history):
            loadingIndicator.stopAnimating()
            emptyStateLabel.isHidden = true
            tableView.isHidden = false
            
            self.savedDays = history.sorted(by: { day0, day1 in
                    let time0 = day0.items.last?.time ?? "00:00:00"
                    let time1 = day1.items.last?.time ?? "00:00:00"
                    return time0 > time1
                })
            
            self.tableView.reloadData()
            
        case .empty:
            loadingIndicator.stopAnimating()
            emptyStateLabel.text = "No History"
            emptyStateLabel.isHidden = false
            tableView.isHidden = true
            self.savedDays = []
            self.tableView.reloadData()
            print("Tampilkan View Kosong")
            
        case .error(let message):
            loadingIndicator.stopAnimating()
            emptyStateLabel.isHidden = true
            tableView.isHidden = false
            print("Error: \(message)")
        }
    }
    
    @objc private func handleRefresh() {
        presenter?.loadAllHistory()
        refreshControl.endRefreshing()
    }
    
    @objc private func closeHistoryPage() {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return savedDays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDays[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherDayHeaderView.identifier) as? WeatherDayHeaderView else {
            return nil
        }
        
        let dayData = savedDays[section]
        let cityName = dayData.items.first?.titleCity ?? "Unknown City"
        
        header.configure(day: dayData, cityName: cityName)
        
        header.onDeleteDay = { [weak self] in
            guard let self = self else {return}
            SwiftDataManager.shared.deleteFromDatabase(object: dayData)
            self.presenter?.loadAllHistory()
        }
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherItemCell.identifier, for: indexPath) as? WeatherItemCell else {
           return UITableViewCell()
        }
        let item = savedDays[indexPath.section].items[indexPath.row]
        
        cell.configure(item: item)
        
        cell.onDeleteItem = {[weak self] in
            guard let self = self else {return}
            SwiftDataManager.shared.deleteFromDatabase(object: item)
            self.presenter?.loadAllHistory()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return UITableView.automaticDimension
        }
}
