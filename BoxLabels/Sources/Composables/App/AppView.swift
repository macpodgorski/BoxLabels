//
//  AppView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Perception.Bindable var store: StoreOf<AppFeature>

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
  AppView(
    store: Store(
      initialState: AppFeature.State(
        boxesList: BoxesListFeature.State()
      )
    ) {
      AppFeature()
    }
  )
}
