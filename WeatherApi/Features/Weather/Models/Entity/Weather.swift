//
//  Weather.swift
//  WeatherApi
//
//  Created by Kalvin on 18/03/26.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let cityName: String
    let temperature: String
    let description: String
    let iconURL: String
}
