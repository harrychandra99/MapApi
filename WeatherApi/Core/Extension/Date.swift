//
//  Date.swift
//  WeatherApi
//
//  Created by Kalvin on 18/05/26.
//
import Foundation

extension Date {

    func toLocalTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
