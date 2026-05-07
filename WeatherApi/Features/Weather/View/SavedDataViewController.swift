//
//  SavedDataController.swift
//  WeatherApi
//
//  Created by Kalvin on 06/05/26.
//

import UIKit

class SavedDataViewController: UIViewController {
    
    private var sectionData: [WeatherDayEntity] = []
    
    private var presenter = SavedDataPresenter()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    func setupUiI() {
        let label = UILabel()
        label.text = "Hello, UIKit!"
        label.textAlignment = .center
        view.addSubview(label)
    }
    
    
}
