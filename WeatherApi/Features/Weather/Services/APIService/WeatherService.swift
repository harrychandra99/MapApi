//
//  LoadService.swift
//  WeatherApi
//
//  Created by Kalvin on 15/03/26.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    private let baseURLWeather: String = Constant.API.baseWeatherURL
    private let pathWeather: String = Constant.API.pathWeather
    private let apiKeyWeather = Secrets.apiKeyWeather
    
    func fetchWeathers(lat: Double, lon: Double) async throws -> WeatherDTO {
        let queries = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
//            URLQueryItem(name: "units", value: "metric")
        ]
        return try await URLBuilder.build(path: Constant.API.pathWeather, queryItems: queries)
    }
    
    func fetchCityCoordinates(city: String) async throws -> [CityDTO] {
        let queries = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "limit", value: "5")
        ]
        return try await URLBuilder.build(path: Constant.API.pathCity, queryItems: queries)
    }
    
}
