//
//  MapTheme+Mapbox.swift
//  GameMaps
//
//  Traduce cada tema a un estilo de Mapbox. Aqui se agregaran los estilos
//  propios (por ejemplo el tema de bloques) cuando esten listos.
//

import MapboxMaps

extension MapTheme {
    var styleURI: StyleURI {
        switch self {
        case .dark: .dark
        case .streets: .streets
        case .satellite: .satelliteStreets
        }
    }
}
