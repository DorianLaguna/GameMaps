//
//  MapViewModel.swift
//  GameMaps
//

import MapboxMaps
import Observation

@Observable
final class MapViewModel {
    let settings: SettingsStore
    let location: LocationService

    /// Camara que sigue al jugador en 3D.
    var viewport: Viewport = MapViewModel.followPlayer

    static let followPlayer: Viewport = .followPuck(zoom: 16, bearing: .heading, pitch: 60)

    init(settings: SettingsStore = SettingsStore(), location: LocationService = LocationService()) {
        self.settings = settings
        self.location = location
    }

    var theme: MapTheme { settings.selectedTheme }

    func onAppear() {
        location.requestPermissionIfNeeded()
    }

    func select(_ theme: MapTheme) {
        settings.select(theme)
    }

    /// Regresa la camara al jugador si el usuario movio el mapa.
    func recenter() {
        viewport = Self.followPlayer
    }
}
