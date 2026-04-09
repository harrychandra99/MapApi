//
//  Double.swift
//  WeatherApi
//
//  Created by Kalvin on 08/04/26.
//

import Foundation

extension Double {
    func toCelsius() -> String {
        let celsius = Int((self - 273.15).rounded())
        return "\(celsius)°C"
    }
}

