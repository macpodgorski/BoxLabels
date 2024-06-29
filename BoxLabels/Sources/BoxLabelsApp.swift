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
    @MainActor
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    TabView {
                        AppView(store: Self.store)
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
                    .navigationTitle("BoxLabels")
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
