//
//  DataMappable.swift
//  WeatherApi
//
//  Created by Kalvin on 13/05/26.
//
import SwiftData

protocol DataMappable: PersistentModel{
    associatedtype Source
    
    static func mapFrom(_ source: Source) -> Self
}
