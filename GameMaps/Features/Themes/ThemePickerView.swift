//
//  ThemePickerView.swift
//  GameMaps
//

import SwiftUI

struct ThemePickerView: View {
    @Binding var selection: MapTheme

    var body: some View {
        Picker("Tema", selection: $selection) {
            ForEach(MapTheme.allCases) { theme in
                Text(theme.title).tag(theme)
            }
        }
        .pickerStyle(.segmented)
        .padding(6)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}
