//
//  WeatherItemEntity.swift
//  WeatherApi
//
//  Created by Kalvin on 07/05/26.
//

import Foundation
import SwiftData

@Model
class WeatherDayEntity {
    @Attribute(.unique) var dateTitle: String
        
        @Relationship(deleteRule: .cascade)
        var items: [WeatherItemEntity] = []
        
        init(dateTitle: String) {
            self.dateTitle = dateTitle
        }
}

@Model
class WeatherItemEntity {
    var titleCity: String
    var time: String
    var mainWeather: String
    var descriptionWeather: String
    var temperature: String
    var temperatureMin: String
    var temperatureMax: String
    var latitude: Double
    var longitude: Double
    
    var parentDay: WeatherDayEntity?
    
    init(titleCity: String, time: String, mainWeather: String, descriptionWeather: String, temperature: String, temperatureMin: String, temperatureMax: String, latitude: Double, longitude: Double) {
        self.titleCity = titleCity
        self.time = time
        self.mainWeather = mainWeather
        self.descriptionWeather = descriptionWeather
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.latitude = latitude
        self.longitude = longitude
    }
}
