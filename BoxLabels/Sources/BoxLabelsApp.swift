//
//  BoxLabelsApp.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 04/05/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BoxLabelsApp: App {
    static let store = Store(initialState: BoxesFeature.State()) {
        BoxesFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                TabView {
                    BoxesView(store: BoxLabelsApp.store)
                        .tabItem {
                            Label("Home", systemImage: "shippingbox.fill")
                    }
                    ScanView()
                        .tabItem {
                            Label("Scan", systemImage: "qrcode")
                        }

                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }

                Image("box-closed")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.03)
            }
        }
    }
}
