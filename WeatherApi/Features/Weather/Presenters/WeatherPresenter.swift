//
//  UserPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//

import Foundation

class WeatherPresenter: WeatherPresenterProtocol {
    
    weak var view: WeatherViewProtocol?
    private let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchData(lat: -6.2, lon: 106.8)
    }
    
    func fetchData(lat: Double, lon: Double) {
        
        view?.showLoading()
        
        Task {
            do {
                let dto = try await service.fetchWeathers(lat: lat, lon: lon)
                
                let weatherData = WeatherMapper.map(dto: dto)
                
                await MainActor.run {
                    view?.hideLoading()
                    view?.display(weather: weatherData)
                }
            } catch {
                await MainActor.run {
                    view?.hideLoading()
                    view?.showError("Gagal Fetch Api: \(error.localizedDescription)")
                }
            }
        }
    }
}
