//
//  GameMapsApp.swift
//  GameMaps
//

import SwiftUI

@main
struct GameMapsApp: App {
    init() {
        AppConfig.configureMapbox()
    }

    var body: some Scene {
        WindowGroup {
            MapScreen()
        }
    }
}
