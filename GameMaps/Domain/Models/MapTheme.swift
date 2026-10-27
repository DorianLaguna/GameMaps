//
//  MapTheme.swift
//  GameMaps
//
//  Modelo puro (sin Mapbox) para poder probarlo y guardarlo facilmente.
//  La traduccion a estilos de Mapbox vive en Features/Map/MapTheme+Mapbox.swift.
//

import Foundation

enum MapTheme: String, CaseIterable, Identifiable {
    case dark
    case streets
    case satellite

    static let defaultTheme: MapTheme = .dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dark: "Oscuro"
        case .streets: "Calles"
        case .satellite: "Satélite"
        }
    }
}
