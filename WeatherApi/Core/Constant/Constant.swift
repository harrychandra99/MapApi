//
//  Constant.swift
//  WeatherApi
//
//  Created by Kalvin on 15/03/26.
//

import SwiftUI

struct Constant {
    struct API {
        static let baseUrl = "https://api.openweathermap.org"
        static let path = "data/2.5/weather"
        static let apiKey = "97dfebc5b669ff4bbe7a89f206f318a7"
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
