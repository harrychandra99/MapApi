//
//  WeatherState.swift
//  WeatherApi
//
//  Created by Kalvin on 10/04/26.
//

import Foundation

class WeatherState: ObservableObject {
    @Published var currentState: State = .idle
    @Published var cityResults: [CityEntity] = []
}

extension WeatherState {
    enum State: Equatable {
        case idle
        case loading
        case success(WeatherEntity)
        case error(String)
    }
}

extension WeatherState: WeatherViewProtocol {
    func showLoading() { currentState = .loading }
    func hideLoading() {}
    func displayData(_ weather: WeatherEntity) {
        currentState = .success(weather)
        self.cityResults = []
    }
    func displayCityResults(_ cities: [CityEntity]) {
        self.cityResults = cities
    }
    func displayError(_ message: String) {
        currentState = .error(message)
    }
}

