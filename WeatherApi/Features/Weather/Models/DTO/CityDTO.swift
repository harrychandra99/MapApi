//
//  CityDTO.swift
//  WeatherApi
//
//  Created by Kalvin on 22/04/26.
//

import Foundation

struct CityDTO: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let localNames: LocalNames
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
        case localNames = "local_names"
    }
}

struct LocalNames: Decodable {
    let en: String
    let id: String
}
