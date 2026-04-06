//
//  WeatherMapper.swift
//  WeatherApi
//
//  Created by Kalvin on 18/03/26.
//

import Foundation

struct WeatherMapper {
    
    static func map(dto: WeatherDTO) -> Weather {
        
        let celciusValue = Int((dto.main.temp - 273.15).rounded())
        let tempString = "\(celciusValue)°C"
        
        let firstWeather = dto.weather.first
        let description = firstWeather?.description.capitalized ?? "No Description"
        
        let iconName = getSystemIcon(from: firstWeather?.icon ?? "")
        
        return Weather(
            cityName: dto.name,
            temperature: tempString,
            description: description,
            iconURL: iconName
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
