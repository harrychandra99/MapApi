//
//  CityEntity.swift
//  WeatherApi
//
//  Created by Kalvin on 22/04/26.
//

import Foundation

struct CityEntity: Equatable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let localNameEnglish: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
