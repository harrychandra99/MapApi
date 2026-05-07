//
//  CityMapper.swift
//  WeatherApi
//
//  Created by Kalvin on 22/04/26.
//

import Foundation

struct CityMapper {
    
    static func mapCity(dto: CityDTO) -> CityEntity {
        let id = dto.id
        let cityName = dto.name
        let localNameEnglish = dto.localNames.en
        let localNameIndo = dto.localNames.id
        let lat: Double = dto.lat
        let lon: Double = dto.lon
        let country: String = dto.country
        let state: String = dto.state
        
        return CityEntity (id: id,
                           name: cityName,
                           localNameEnglish: localNameEnglish,
                           localNameIndo: localNameIndo,
                           lat: lat,
                           lon: lon,
                           country: country,
                           state: state)
    }
}
