//
//  WeatherItemEntity.swift
//  WeatherApi
//
//  Created by Kalvin on 07/05/26.
//

import Foundation
import SwiftData

@Model
final class WeatherDayEntity {
    @Attribute(.unique) var dateTitle: String
    
    @Relationship(deleteRule: .cascade)
    var items: [WeatherItemEntity] = []
    
    init(dateTitle: String) {
        self.dateTitle = dateTitle
    }
}

@Model
final class WeatherItemEntity {
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

extension WeatherDayEntity: DataMappable {
    typealias Source = WeatherEntity
    
    static func mapFrom(_ api: WeatherEntity) -> WeatherDayEntity {
        let dayEntity = WeatherDayEntity(
            dateTitle: "\(api.cityName) - \(Date().formatted(date: .abbreviated, time: .omitted))"
        )
        
        let itemEntity = WeatherItemEntity(
            titleCity: api.cityName,
            time: Date().toLocalTimeString(),
            mainWeather: api.mainWeather,
            descriptionWeather: api.descriptionWeather,
            temperature: "\(api.temperatureCurrent)°",
            temperatureMin: "\(api.temperatureMin)°",
            temperatureMax: "\(api.temperatureMax)°",
            latitude: api.latitude,
            longitude: api.longitude
        )
        
        dayEntity.items.append(itemEntity)
        itemEntity.parentDay = dayEntity
        
        return dayEntity 
    }
}
