//
//  CityEntity.swift
//  WeatherApi
//
//  Created by Kalvin on 22/04/26.
//

import Foundation

struct CityEntity: Equatable {
    let id: UUID
    let name: String
    let localNameEnglish: String
    let localNameIndo: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
