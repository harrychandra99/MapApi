//
//  UserPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//

import Foundation

protocol WeatherPresenterProtocol: ObservableObject {
    
    var cityName: String { get }
    var temperature: String { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchData(lat: Double, lon:Double)
}

@MainActor
class WeatherPresenter: WeatherPresenterProtocol{
    
    @Published var cityName: String = ""
    @Published var temperature: String = "--"
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
                
                let weatherDTO = WeatherMapper.map(dto: dto)
                
                self.cityName = weatherDTO.cityName
                self.temperature = weatherDTO.temperature
                self.isLoading = false
                
                }
            } catch {
                self.isLoading = false
                print("Error: \(error)")
            }
        }
    }
}
