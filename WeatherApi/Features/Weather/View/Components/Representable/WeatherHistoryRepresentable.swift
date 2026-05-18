//
//  WeatherHistoryRepresentable.swift
//  WeatherApi
//
//  Created by Kalvin on 17/05/26.
//

import SwiftUI
import UIKit
import SwiftData

struct WeatherHistoryRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let historyVC = WeatherHistoryViewController()
        
        let navigationController = UINavigationController(rootViewController: historyVC)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
}
