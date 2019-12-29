//
//  LocationManager.swift
//  Forecast
//
//  Created by Sebastien Gohier on 29/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    let notificationName = Notification.Name("LocationAvailable")
    var location = CLLocationCoordinate2D()
    
    func initializeLocationManager() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = manager.location?.coordinate else { return }
        location = loc
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
        
}
