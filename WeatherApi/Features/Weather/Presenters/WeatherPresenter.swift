//
//  UserPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//

import Foundation

@MainActor
protocol WeatherViewProtocol: AnyObject {
    
    func showLoading()
    func hideLoading()
    func displayData(_ weather: WeatherEntity)
    func displayError(_ message: String)
}

@MainActor
class WeatherPresenter{
    
    weak var view: WeatherViewProtocol?
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    
    func fetchData(lat: Double, lon: Double) {
        
        view?.showLoading()
        
        Task {
            do {
                let dto = try await service.fetchWeathers(lat: lat, lon: lon)
                let mappedResult = WeatherMapper.map(dto: dto)
                
                view?.displayData(mappedResult)
                view?.hideLoading()
                
                //print(dto)
                //print(mappedResult)
                
            } catch {
                view?.displayError(error.localizedDescription)
                view?.hideLoading()
                //print(error.localizedDescription)
            }
        }
    }
}
