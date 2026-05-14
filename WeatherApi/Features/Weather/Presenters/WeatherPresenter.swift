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
    func displayCityResults(_ cities: [CityEntity])
    func displayError(_ message: String)
}

@MainActor
class WeatherPresenter{
    
    private let modelContext: ModelContext
    weak var view: WeatherViewProtocol?
    private let service: WeatherService
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    private var searchTask: Task<Void, Never>?
    
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
                self?.fetchDataWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
            .store(in: &cancellables)
    }
    
    func saveToDatabase(apiData: WeatherEntity) {
        SwiftDataManager.shared.saveToDatabase(input: apiData, as: WeatherDayEntity.self)
    }
    
    func fetchDataWeather(lat: Double, lon: Double) {
        
        Task {
            
            view?.showLoading()
            
            do {
                let dto = try await service.fetchWeathers(lat: lat, lon: lon)
                let mappedResult = WeatherMapper.mapWeather(dto: dto)
                
//                self.saveToDatabase(apiData: mappedResult)
                
                view?.displayData(mappedResult)
                view?.hideLoading()
                
            } catch {
                view?.displayError(error.localizedDescription)
                view?.hideLoading()
                
            }
        }
    }
    
    func searchCity(name: String) {
        let cleanName = name.trimmingCharacters(in: .whitespaces)
        searchTask?.cancel()
        
        if cleanName.count <= 2 {
            view?.displayCityResults([])
            return
        }
        
        searchTask = Task {
            do {
                try await Task.sleep(nanoseconds: 300_000_000)
                if Task.isCancelled { return }
                
                let cityDTOs = try await service.fetchCityCoordinates(city: cleanName)
                print("🔍 API Response: Berhasil ambil \(cityDTOs.count) kota untuk keyword: \(cleanName)")
                
                let cityEntities = cityDTOs.map { CityMapper.mapCity(dto: $0)}
                print("✅ Mapping: Berhasil mengubah ke \(cityEntities.count) Entities")
                
                if !Task.isCancelled {
                    view?.displayCityResults(cityEntities)
                }
            } catch{
                if error is CancellationError{ return }
                
                view?.displayError(error.localizedDescription)
            }
        }
    }
}



