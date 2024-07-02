//
//  BoxFormFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct BoxFormFeature {
    @ObservableState
    struct State: Equatable {
        var box: Box
        var focus: Field? = .title

        enum Field: Hashable {
            case item(Item.ID)
            case title
        }
    }
    enum Action: BindableAction {
        case addItemButtonTapped
        case binding(BindingAction<State>)
        case onDeleteItems(IndexSet)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .addItemButtonTapped:
                let item = Item(id: Item.ID())
                state.box.boxItems.append(item)
                state.focus = .item(item.id)
                return .none

            case .binding:
                return .none

            case let .onDeleteItems(indices):
                state.box.boxItems.remove(atOffsets: indices)
                guard
                    !state.box.boxItems.isEmpty,
                    let firstIndex = indices.first
                else {
                    state.box.boxItems.append(Item(id: Item.ID()))
                    return .none
                }
                let index = min(firstIndex, state.box.boxItems.count - 1)
                state.focus = .item(state.box.boxItems[index].id)
                return .none
            }
        }
    }
}
