//
//  UserPresenter.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//

import Foundation
import Combine
import SwiftData

@MainActor
protocol WeatherViewProtocol: AnyObject {
    
    func showLoading()
    func hideLoading()
    func displayData(_ weather: WeatherEntity)
    func displayError(_ message: String)
}

@MainActor
class WeatherPresenter{
    
    private let modelContext: ModelContext
    weak var view: WeatherViewProtocol?
    private let service: WeatherService
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(service: WeatherService, modelContext: ModelContext) {
        self.service = service
        self.modelContext = modelContext
        setupLocationObserver()
    }
    
    func startLocationRequest() {
        view?.showLoading()
        locationManager.requestLocation()
    }
    
    private func setupLocationObserver() {
        locationManager.$location
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink {[weak self] coordinate in
                self?.fetchData(lat: coordinate.latitude, lon: coordinate.longitude)
            }
            .store(in: &cancellables)
    }
    
    func saveToDatabase(apiData: WeatherEntity) {
        let persistentObject = mapToPersistentEntity(apiData)
        modelContext.insert(persistentObject)
        print("Success: Saved \(apiData.cityName) to local database.")
    }
    
    private func mapToPersistentEntity(_ api: WeatherEntity) -> WeatherDayEntity{
        let dayEntity = WeatherDayEntity(dateTitle: "\(api.cityName) - \(Date().formatted(date: .abbreviated, time: .omitted))")
        let itemEntity = WeatherItemEntity(
            titleCity: api.cityName,
            time: "Current",
            mainWeather: api.mainWeather,
            descriptionWeather: api.descriptionWeather,
            temperature: "\(api.temperatureCurrent)°",
            temperatureMin: "\(api.temperatureMin)°",
            temperatureMax: "\(api.temperatureMax)°",
            latitude: api.latitude,
            longitude: api.longtitude
        )
        
        dayEntity.items.append(itemEntity)
        
        return dayEntity
    }
    
    func fetchData(lat: Double, lon: Double) {
        
        Task {
            do {
                let dto = try await service.fetchWeathers(lat: lat, lon: lon)
                let mappedResult = WeatherMapper.mapWeather(dto: dto)
                
                self.saveToDatabase(apiData: mappedResult)
                
                view?.displayData(mappedResult)
                view?.hideLoading()
                
            } catch {
                view?.displayError(error.localizedDescription)
                view?.hideLoading()
                
            }
        }
    }
}
