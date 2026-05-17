//
//  SavedDataPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 06/05/26.
//

import Foundation

@MainActor
protocol WeatherHistoryViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayWeatherHistory(_ history: [WeatherDayEntity])
    func displayError(_ message: String)
}

@MainActor
final class WeatherHistoryPresenter {
    weak var view: WeatherHistoryViewProtocol?
    
    init(view: WeatherHistoryViewProtocol){
        self.view = view
    }
    
    func loadAllHistory() {
        view?.showLoading()
        
        let results:[WeatherDayEntity] = SwiftDataManager.shared.loadFromDatabase(sortBy: [])
        view?.hideLoading()
        view?.displayWeatherHistory(results)
    }
}
