//
//  Int.swift
//  WeatherApi
//
//  Created by Kalvin on 09/04/26.
//

import Foundation

extension Int{
    func toLocalTimeString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: self)
        return formatter.string(from: Date())
    }
}
