//
//  LocationManager.swift
//  WeatherApi
//
//  Created by Kalvin on 04/05/26.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var authorization: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        location = locations.first?.coordinate
        manager.stopUpdatingLocation()
    }
    
}
