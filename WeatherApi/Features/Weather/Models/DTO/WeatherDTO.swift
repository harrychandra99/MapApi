//
//  WeatherModel.swift
//  WeatherApi
//
//  Created by Kalvin on 13/03/26.
//
import Foundation

struct WeatherDTO: Decodable {
    let coord: CoordDTO
    let weather: [WeatherInfoDTO]
    let main: MainDTO
    let timezone: Int
    let id: Int
    let name: String
}

struct CoordDTO: Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherInfoDTO: Decodable{
    var id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainDTO: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}




