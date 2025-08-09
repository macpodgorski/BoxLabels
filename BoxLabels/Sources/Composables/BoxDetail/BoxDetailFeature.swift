//
//  BoxDetailFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 26/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BoxDetailFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case alert(AlertState<Alert>)
        case edit(BoxFormFeature)
        @CasePathable
        enum Alert {
            case confirmButtonTapped
        }
    }

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        @Shared var box: Box
    }

    enum Action {
        case deleteButtonTapped
        case editButtonTapped
        case destination(PresentationAction<Destination.Action>)
        case cancelEditButtonTapped
        case saveEditButtonTapped
    }

    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination(.presented(.alert(.confirmButtonTapped))):
                @Shared(.boxes) var boxes: IdentifiedArrayOf<Box> = []
                boxes.remove(id: state.box.id)
                return .run { _ in await dismiss() }

            case .destination:
                return .none

            case .deleteButtonTapped:
                state.destination = .alert(.deleteBox)
                return .none

            case .editButtonTapped:
                state.destination = .edit(BoxFormFeature.State(box: state.box))
                return .none

            case .cancelEditButtonTapped:
                state.destination = nil
                return .none

            case .saveEditButtonTapped:
                @Shared(.boxes) var boxes: IdentifiedArrayOf<Box> = []
                guard let editedBox = state.destination?.edit?.box else {
                    return .none
                }
                state.box = editedBox
                boxes.updateOrAppend(editedBox)

                state.destination = nil
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension AlertState where Action == BoxDetailFeature.Destination.Alert {
    static let deleteBox = Self {
        TextState("Delete?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmButtonTapped) {
            TextState("Yes")
        }
        ButtonState(role: .cancel) {
            TextState("Cancel")
        }
    } message: {
        TextState("Are you sure you want to delete this box?")
    }
}
