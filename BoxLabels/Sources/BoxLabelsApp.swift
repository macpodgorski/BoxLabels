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
            AppView(store: Self.store)
                .tint(.brown)
        }
    }
}
