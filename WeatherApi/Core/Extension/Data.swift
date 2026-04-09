//
//  Data.swift
//  WeatherApi
//
//  Created by Kalvin on 09/04/26.
//

import Foundation

extension Data {
    func debugJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
           let str = String(data: prettyData, encoding: .utf8) {
            print(str)
        }
    }
}
