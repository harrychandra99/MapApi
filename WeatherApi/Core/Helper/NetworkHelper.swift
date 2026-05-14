//
//  NetworkHelper.swift
//  WeatherApi
//
//  Created by Kalvin on 14/05/26.
//
import Foundation


struct URLBuilder {
    static func build<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem]
    ) async throws -> T {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constant.API.baseWeatherURL
        components.path = path
        
        var allQueries = queryItems
        allQueries.append(URLQueryItem(name: "appid", value: Secrets.apiKeyWeather))
        
        components.queryItems = allQueries
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return try await NetworkManager.shared.loadAPI(url: url)
    }
}

