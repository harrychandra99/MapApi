//
//  WeatherServiceProtocol.swift
//  WeatherApi
//
//  Created by Kalvin on 15/03/26.
//

protocol WeatherServiceProtocol {
    func fetchWeathers(lat: Double, lon: Double) async throws -> WeatherDTO
}
