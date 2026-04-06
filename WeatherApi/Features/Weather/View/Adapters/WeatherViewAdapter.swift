//
//  WeatherViewAdapter.swift
//  WeatherApi
//
//  Created by Kalvin on 07/04/26.
//

import Foundation
import Combine

class WeatherViewAdapter: ObservableObject, WeatherViewProtocol {
    
    @Published var cityName: String = "Loading..."
    @Published var temperature: String = "--°C"
    @Published var condition: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func showLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func display(weather: Weather) {
        DispatchQueue.main.async {
            self.cityName = weather.cityName
            self.temperature = weather.temperature
            self.condition = weather.description
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async{
            self.errorMessage = message
        }
    }
}
