//
//  AddBoxFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 24/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddBoxFeature {
    @ObservableState
    struct State: Equatable {
        var box: Box
    }
    enum Action {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setTitle(String)
        case setDescription(String)
        case setSize(String)
        enum Delegate: Equatable {
            case saveBox(Box)
        }
    }
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .delegate:
                return .none

            case .saveButtonTapped:
                return .run { [box = state.box] send in
                    await send(.delegate(.saveBox(box)))
                    await self.dismiss()
                }

            case let .setTitle(title):
                state.box.title = title
                return .none

            case let .setDescription(description):
                state.box.description = description
                return .none

            case let .setSize(size):
                state.box.size = size
                return .none
            }
        }
    }
}
