//
//  Constant.swift
//  WeatherApi
//
//  Created by Kalvin on 15/03/26.
//

import SwiftUI

enum Constant {
    enum API {
        static let baseUrl = "https://api.openweathermap.org"
        static let path = "data/2.5/weather"
        
    }
    
    enum WeatherIcon: String {
        case sun = "sun.max.fill"
        case moon = "moon.stars.fill"
        case cloudSun = "cloud.sun.fill"
        case cloud = "cloud.fill"
        case cloudRain = "cloud.rain.fill"
        case storm = "cloud.bolt.fill"
        case snow = "snow"
    }
    
}
