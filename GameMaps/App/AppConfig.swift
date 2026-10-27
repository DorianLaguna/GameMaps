//
//  AppConfig.swift
//  GameMaps
//
//  Configuracion global. El token viene de .env -> build setting
//  MAPBOX_ACCESS_TOKEN -> Info.plist (MBXAccessToken).
//

import Foundation
import MapboxMaps

enum AppConfig {
    /// Token publico de Mapbox, o cadena vacia si no esta configurado.
    static var mapboxAccessToken: String {
        let value = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as? String ?? ""
        // Si .env no define la variable, Xcode deja el texto "$(MAPBOX_ACCESS_TOKEN)" o vacio.
        return value.hasPrefix("pk.") ? value : ""
    }

    static var hasMapboxToken: Bool { !mapboxAccessToken.isEmpty }

    static func configureMapbox() {
        guard hasMapboxToken else { return }
        MapboxOptions.accessToken = mapboxAccessToken
    }
}
