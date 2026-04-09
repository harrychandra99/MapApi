//
//  Helper.swift
//  WeatherApi
//
//  Created by Kalvin on 08/04/26.
//
import Foundation

struct Helper {
    static func formatCelsius(_ kelvin: Double) -> String {
        let celsius = Int((kelvin - 273.15).rounded())
        return "\(celsius)°C"
    }
}
