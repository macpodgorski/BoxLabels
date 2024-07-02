//
//  HomeTabView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct HomeTabView: View {
    @Perception.Bindable var store: StoreOf<AppFeature.HomeTabFeature>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            BoxesListView(store: store.scope(state: \.boxesList, action: \.boxesList))
        } destination: { store in
            switch store.case {
            case let .detail(detailStore):
                BoxDetailView(store: detailStore)
            }
        }
    }
}

#Preview {
  HomeTabView(
    store: Store(
      initialState: AppFeature.HomeTabFeature.State(
        boxesList: BoxesListFeature.State()
      )
    ) {
        AppFeature.HomeTabFeature()
    }
  )
}
