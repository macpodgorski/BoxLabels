//
//  AppFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 02/07/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    enum Tab {
        case home, scan, settings
    }
    @ObservableState
    struct State: Equatable {
        var currentTab = Tab.home
        var home = HomeTabFeature.State()
        var scan = ScanTabFeature.State()
    }

    enum Action {
        case home(HomeTabFeature.Action)
        case scan(ScanTabFeature.Action)
        case selectTab(Tab)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeTabFeature()
        }
        Scope(state: \.scan, action: \.scan) {
            ScanTabFeature()
        }

        Reduce { state, action in
            switch action {
            case .home, .scan:
                return .none
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
            }
        }
    }
}

extension PersistenceReaderKey
where Self == PersistenceKeyDefault<FileStorageKey<IdentifiedArrayOf<Box>>> {
  static var boxes: Self {
    PersistenceKeyDefault(
      .fileStorage(.documentsDirectory.appending(component: "boxes.json")),
      []
    )
  }
}
