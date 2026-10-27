//
//  SettingsStore.swift
//  GameMaps
//
//  Preferencias del usuario guardadas en UserDefaults.
//

import Foundation
import Observation

@Observable
final class SettingsStore {
    private enum Keys {
        static let selectedTheme = "settings.selectedTheme"
    }

    private let defaults: UserDefaults

    private(set) var selectedTheme: MapTheme

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.selectedTheme = defaults.string(forKey: Keys.selectedTheme)
            .flatMap(MapTheme.init(rawValue:)) ?? MapTheme.defaultTheme
    }

    func select(_ theme: MapTheme) {
        selectedTheme = theme
        defaults.set(theme.rawValue, forKey: Keys.selectedTheme)
    }
}
