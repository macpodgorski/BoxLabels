//
//  BoxDetailView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 26/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct BoxDetailView: View {
    @Perception.Bindable var store: StoreOf<BoxDetailFeature>

    var body: some View {
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.box.title))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    NavigationStack {
        BoxDetailView(
            store: Store(
                initialState: BoxDetailFeature.State(
                    box: Box(id: UUID(),
                             title: "Box number 1",
                             qrCode: UIImage().withRenderingMode(.alwaysOriginal),
                             description: "box in living room",
                             size: "Medium",
                             boxItems: ["phone", "headphones"])
                )
            ) {
               BoxDetailFeature()
            }
        )
    }
}
