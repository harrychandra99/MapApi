//
//  Weather.swift
//  WeatherApi
//
//  Created by Kalvin on 18/03/26.
//

import Foundation

struct WeatherEntity: Identifiable {
    let id: Int
    let cityName: String
    
    let temperatureCurrent: String
    let temperatureMin: String
    let temperatureMax: String
    
    let idWeather: Int
    let mainWeather: String
    let descriptionWeather: String
    let iconCodeWeather: String
    
    let latitude: Double
    let longtitude: Double
}
