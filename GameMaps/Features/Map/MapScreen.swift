//
//  MapScreen.swift
//  GameMaps
//
//  Pantalla principal: mapa a pantalla completa con el jugador y el selector de tema.
//

import SwiftUI
import MapboxMaps

struct MapScreen: View {
    @State private var viewModel = MapViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel

        ZStack {
            if AppConfig.hasMapboxToken {
                Map(viewport: $viewModel.viewport) {
                    Puck2D(bearing: .heading)
                }
                .mapStyle(MapStyle(uri: viewModel.theme.styleURI))
                .ignoresSafeArea()
            } else {
                MissingTokenView()
            }

            VStack {
                if viewModel.location.isDenied {
                    LocationDeniedBanner()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: viewModel.recenter) {
                        Image(systemName: "location.fill")
                            .font(.title3)
                            .padding(12)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .accessibilityLabel("Centrar en mi ubicación")
                }
                ThemePickerView(
                    selection: Binding(
                        get: { viewModel.theme },
                        set: { viewModel.select($0) }
                    )
                )
            }
            .padding()
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

private struct MissingTokenView: View {
    var body: some View {
        ContentUnavailableView(
            "Falta el token de Mapbox",
            systemImage: "key.slash",
            description: Text("Pon tu token público en el archivo .env (MAPBOX_ACCESS_TOKEN=pk...) y vuelve a compilar.")
        )
    }
}

private struct LocationDeniedBanner: View {
    var body: some View {
        Label("Activa la ubicación en Ajustes para verte en el mapa.", systemImage: "location.slash")
            .font(.footnote)
            .padding(10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MapScreen()
}
