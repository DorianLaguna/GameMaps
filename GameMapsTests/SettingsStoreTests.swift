//
//  SettingsStoreTests.swift
//  GameMapsTests
//

import Foundation
import Testing
@testable import GameMaps

@MainActor
struct SettingsStoreTests {
    /// UserDefaults aislado para que las pruebas no toquen los ajustes reales.
    private func makeDefaults() -> UserDefaults {
        let suite = "GameMapsTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defaults.removePersistentDomain(forName: suite)
        return defaults
    }

    @Test func usaElTemaPorDefectoSiNoHayNadaGuardado() {
        let store = SettingsStore(defaults: makeDefaults())
        #expect(store.selectedTheme == MapTheme.defaultTheme)
    }

    @Test func guardaYRecuperaElTemaElegido() {
        let defaults = makeDefaults()
        SettingsStore(defaults: defaults).select(.satellite)

        let reloaded = SettingsStore(defaults: defaults)
        #expect(reloaded.selectedTheme == .satellite)
    }

    @Test func ignoraValoresGuardadosInvalidos() {
        let defaults = makeDefaults()
        defaults.set("tema-que-no-existe", forKey: "settings.selectedTheme")

        let store = SettingsStore(defaults: defaults)
        #expect(store.selectedTheme == MapTheme.defaultTheme)
    }
}
