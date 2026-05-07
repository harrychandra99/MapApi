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
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = baseURLWeather
        components.path = pathWeather
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "apiKey", value: apiKeyWeather)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        return try await NetworkManager.shared.loadAPI(url: url)
    }
}
