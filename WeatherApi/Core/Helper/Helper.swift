//
//  Helper.swift
//  WeatherApi
//
//  Created by Kalvin on 08/04/26.
//
import Foundation

struct Helper {
    static func formatCelsius(_ kelvin: Double) -> String {
            let temperature = Measurement(value: kelvin, unit: UnitTemperature.kelvin)
            let formatter = MeasurementFormatter()
            formatter.unitStyle = .medium // Menghasilkan "25°C"
            formatter.numberFormatter.maximumFractionDigits = 0 // Jika ingin tanpa desimal
            
            // Konversi otomatis ke Celsius
            let celsius = temperature.converted(to: .celsius)
            return formatter.string(from: celsius)
        }
}
