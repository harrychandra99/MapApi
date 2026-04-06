//
//  WeatherProtocol.swift
//  WeatherApi
//
//  Created by Kalvin on 07/04/26.
//

import Foundation

protocol WeatherPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    func fetchData(lat: Double, lon:Double)
}

protocol WeatherViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func display(weather: Weather)
    func showError(_ message: String)
}
