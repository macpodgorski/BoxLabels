//
//  HomeView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 24/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct BoxesView: View {
    @Perception.Bindable var store: StoreOf<BoxesFeature>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.boxes) { box in
                    NavigationLink(state: BoxDetailFeature.State(box: box)) {
                        HStack {
                            Text(box.title)
                            Spacer()
                            Button {
                                store.send(.deleteButtonTapped(id: box.id))
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .buttonStyle(.borderless)
                }
            }
            .navigationTitle("BoxLabels")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } destination: { store in
            BoxDetailView(store: store)
        }
        .sheet(
            item: $store.scope(state: \.destination?.addBox, action: \.destination.addBox)
        ) { addBoxStore in
            NavigationStack {
                AddBoxView(store: addBoxStore)
            }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
}

#Preview {
    BoxesView(
        store: Store(
            initialState: BoxesFeature.State(
                boxes: [
                    Box(id: UUID(),
                        title: "Box number 1",
                        qrCode: UIImage().withRenderingMode(.alwaysOriginal),
                        description: "box in living room",
                        size: "Medium",
                        boxItems: ["phone", "headphones"]),
                    Box(id: UUID(),
                        title: "Box number 2",
                        qrCode: UIImage().withRenderingMode(.alwaysOriginal),
                        description: "box in bedroom",
                        size: "Small",
                        boxItems: ["lego", "pillow"])
                ]
            )
        ) {
            BoxesFeature()
        }
    )
}
