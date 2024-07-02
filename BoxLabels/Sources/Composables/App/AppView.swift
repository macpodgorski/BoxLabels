//
//  AppView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 02/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Perception.Bindable var store: StoreOf<AppFeature>

    var body: some View {
        TabView(selection: $store.currentTab.sending(\.selectTab)) {
            HomeTabView(store: store.scope(state: \.home, action: \.home))
                .tag(AppFeature.Tab.home)
                .tabItem { Label("Home", systemImage: "shippingbox.fill") }

            ScanTabView(store: store.scope(state: \.scan, action: \.scan))
                .tag(AppFeature.Tab.scan)
                .tabItem { Label("Scan", systemImage: "qrcode") }
            // SettingsView()
            //  .tabItem {
            //      Label("Settings", systemImage: "gearshape.fill")
            //  }
        }
        .navigationTitle("BoxLabels")
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}
