//
//  LoadService.swift
//  WeatherApi
//
//  Created by Kalvin on 15/03/26.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    private var baseURL: String = Constant.API.baseUrl
    private var path: String = Constant.API.path
    private var apiKey = Secrets.apiKey
    
    func fetchWeathers(lat: Double, lon: Double) async throws -> WeatherDTO {
        let urlString = "\(baseURL)/\(path)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        return try await NetworkManager.shared.request(urlString: urlString)
    }
}
