//
//  UserPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//

import Foundation

@MainActor
protocol WeatherPresenterProtocol: ObservableObject {
    
    var weather: WeatherEntity? {get}
    
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchData(lat: Double, lon:Double)
}

@MainActor
class WeatherPresenter: WeatherPresenterProtocol{
    
    @Published var weather: WeatherEntity?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    
    func fetchData(lat: Double, lon: Double) {
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let dto = try await service.fetchWeathers(lat: lat, lon: lon)
                
                let mappedResult = WeatherMapper.map(dto: dto)
                
                self.weather = mappedResult
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to Load Data: \(error.localizedDescription)"
                self.isLoading = false
                
            }
        }
    }
}
