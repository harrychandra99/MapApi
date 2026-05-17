//
//  WeatherDayHeader.swift
//  WeatherApi
//
//  Created by Kalvin on 17/05/26.
//
import UIKit

class WeatherDayHeaderView: UITableViewHeaderFooterView {
    static let identifier = "WeatherDayHeaderView"
    
    private let containerView = UIView()
    private let dateLabel = UILabel()
    private let cityLabel = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    var onDeleteDay: (() -> Void)?
    
    override init (reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpHeaderUI()
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}

extension WeatherDayHeaderView {
    
    private func setUpHeaderUI() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        dateLabel.font = .systemFont(ofSize: 18, weight: .black)
        cityLabel.font = .systemFont(ofSize: 11, weight: .black)
        cityLabel.textColor = .systemBlue
        
        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.tintColor = .systemGray4
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        contentView.addSubview(containerView)
        [dateLabel, cityLabel, deleteButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2),
            cityLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            deleteButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
}

extension WeatherDayHeaderView {
    @objc private func handleDelete() {
        onDeleteDay?()
    }
    
    func configure(day: WeatherDayEntity, cityName: String) {
        dateLabel.text = day.dateTitle.uppercased()
        cityLabel.text = "📍 \(cityName.uppercased())"
    }
}

