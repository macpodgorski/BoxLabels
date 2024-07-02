//
//  BoxesListView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 24/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct BoxesListView: View {
    @Perception.Bindable var store: StoreOf<BoxesListFeature>

    var body: some View {
        List {
            ForEach(store.$boxes.elements) { $box in
                NavigationLink(state: AppFeature.HomeTabFeature.Path.State.detail(BoxDetailFeature.State(box: $box))) {
                    CardView(box: box)
                }
                .listRowBackground(Color.brown)
                .listRowSeparator(.visible, edges: .all)
            }
            .onDelete { indexSet in
                store.send(.onDelete(indexSet))
            }
        }
        .sheet(item: $store.scope(state: \.addBox, action: \.addBox)) { addBoxStore in
            NavigationStack {
                BoxFormView(store: addBoxStore)
                    .navigationTitle("New box")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                store.send(.cancelButtonTapped)
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                store.send(.confirmButtonTapped)
                            }
                        }
                    }
            }
        }
        .toolbar {
            Button {
                store.send(.addBoxButtonTapped)
            } label: {
                Image(systemName: "plus")
            }
        }
        .navigationTitle("BoxLabels")
    }
}

// #Preview {
//  NavigationStack {
//    BoxesListView(
//      store: Store(
//        initialState: BoxesListFeature.State(
//          boxes: [.mock]
//        )
//      ) {
//        BoxesListFeature()
//              ._printChanges()
//      }
//    )
//  }
// }
