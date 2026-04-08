//
//  WeatherMapper.swift
//  WeatherApi
//
//  Created by Kalvin on 18/03/26.
//

import Foundation

struct WeatherMapper {
    
    static func map(dto: WeatherDTO) -> WeatherEntity {
        
        let idCity = dto.id
        let cityName = dto.name
        let timeZone = dto.timeZone
        
        let currentTemperature = dto.main.temp.toCelsius()
        let minTemperature = dto.main.tempMin.toCelsius()
        let maxTemperature = dto.main.tempMax.toCelsius()
        
        let firstWeather = dto.weather.first
        
        let idWeather = firstWeather?.id ?? 0
        let mainWeather = firstWeather?.main.capitalized ?? "No Weather"
        let descriptionWeather = firstWeather?.description.capitalized ?? "No Description"
        let iconCodeWeather = getSystemIcon(from: firstWeather?.icon ?? "")
        
        let latitude = dto.coord.lat
        let longtitude = dto.coord.lon
        
        return WeatherEntity(
            id: idWeather,
            cityName: cityName,
            temperatureCurrent: currentTemperature,
            temperatureMin: minTemperature,
            temperatureMax: maxTemperature,
            idWeather: idWeather,
            mainWeather: mainWeather,
            descriptionWeather: descriptionWeather,
            iconCodeWeather: iconCodeWeather,
            latitude: latitude,
            longtitude: longtitude
        )
    }
    
    private static func getSystemIcon(from code: String) -> String {
        switch code {
        case "01d":
            return Constant.WeatherIcon.sun.rawValue
        case "01n":
            return Constant.WeatherIcon.moon.rawValue
        case "02d", "02n":
            return Constant.WeatherIcon.cloudSun.rawValue
        case "03d", "04d":
            return Constant.WeatherIcon.cloud.rawValue
        case "09d", "10d":
            return Constant.WeatherIcon.cloudRain.rawValue
        case "11d":
            return Constant.WeatherIcon.storm.rawValue
        case "13d":
            return Constant.WeatherIcon.snow.rawValue
        default:
            return Constant.WeatherIcon.cloud.rawValue
        }
    }
}
