//
//  WeatherHistoryState.swift
//  WeatherApi
//
//  Created by Kalvin on 17/05/26.
//

import Foundation
import SwiftData

class WeatherHistoryState: ObservableObject {
    @Published var currentState: State = .idle
}

extension WeatherHistoryState {
    enum State: Equatable {
        case idle
        case loading
        case success([WeatherDayEntity])
        case empty
        case error(String)
    }
}

extension WeatherHistoryState: WeatherHistoryViewProtocol {
    func showLoading() {
        currentState = .loading
    }
    
    func hideLoading() {
        
    }
    
    func displayWeatherHistory(_ history: [WeatherDayEntity]) {
        if history.isEmpty {
            currentState = .empty
        } else {
            currentState = .success(history)
        }
    }
    
    func displayError(_ message: String) {
        currentState = .error(message)
    }
}
