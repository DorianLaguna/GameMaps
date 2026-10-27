//
//  LocationService.swift
//  GameMaps
//
//  Maneja el permiso de ubicacion. El puck de Mapbox lee el GPS por su cuenta;
//  este servicio solo pide y expone el estado del permiso.
//

import CoreLocation
import Observation

@Observable
final class LocationService: NSObject {
    private let manager = CLLocationManager()

    private(set) var authorizationStatus: CLAuthorizationStatus

    var isAuthorized: Bool {
        authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }

    var isDenied: Bool {
        authorizationStatus == .denied || authorizationStatus == .restricted
    }

    override init() {
        authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self
    }

    func requestPermissionIfNeeded() {
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        Task { @MainActor in
            self.authorizationStatus = status
        }
    }
}
