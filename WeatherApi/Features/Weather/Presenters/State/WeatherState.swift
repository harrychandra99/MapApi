//
//  WeatherState.swift
//  WeatherApi
//
//  Created by Kalvin on 10/04/26.
//

import Foundation

class WeatherState: ObservableObject {
    @Published var weather: WeatherEntity?
    @Published var isLoading = false
    @Published var errorMessage: String?
}

extension WeatherState: WeatherViewProtocol {
    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
    func displayData(_ weather: WeatherEntity) {
        self.weather = weather
        self.errorMessage = nil
    }
    func displayError(_ message: String) {
        self.errorMessage = message
    }
}
