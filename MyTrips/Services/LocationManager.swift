//
//  LocationManager.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 25/01/2024.
//

import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored let manager = CLLocationManager()
    var userLocation: CLLocation?
    var isAuthorized = false

    override init() {
        super.init()
        manager.delegate = self
        startLocationServices()
    }
    func startLocationServices() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            isAuthorized = true
        } else {
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {

        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .restricted:
            isAuthorized = false
        case .denied:
            isAuthorized = false
            print("access denied")
        case .authorizedAlways:
            isAuthorized = true
        case .authorizedWhenInUse:
            isAuthorized = true
        @unknown default:
            isAuthorized = true
            startLocationServices()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
