//
//  BoxFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BoxesFeature {
    @ObservableState
    struct State: Equatable {
        var boxes: IdentifiedArrayOf<Box> = []
        @Presents var destination: Destination.State?
        var path = StackState<BoxDetailFeature.State>()
    }
    enum Action {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
        case deleteButtonTapped(id: Box.ID)
        case path(StackAction<BoxDetailFeature.State, BoxDetailFeature.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: Box.ID)
        }
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                let id = UUID()
                state.destination = .addBox(
                    AddBoxFeature.State(
                        box: Box(id: id,
                                 title: "",
                                 qrCode: generateQRCode(from: id.uuidString),
                                 description: "",
                                 size: "",
                                 boxItems: []
                                )
                    )
                )
                // TODO: make qrcode from id and username in future
                return .none

            case let .destination(.presented(.addBox(.delegate(.saveBox(box))))):
                state.boxes.append(box)
                return .none

            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.boxes.remove(id: id)
                return .none

            case .destination:
                return .none

            case let .deleteButtonTapped(id: id):
                state.destination = .alert(
                    AlertState {
                        TextState("Are you sure?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                            TextState("Delete")
                        }
                    }
                )
                return .none

            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard let detailState = state.path[id: id]
                else { return .none }

                state.boxes.remove(id: detailState.box.id)
                return .none

            case .path:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path) {
            BoxDetailFeature()
        }
    }
}

extension BoxesFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case addBox(AddBoxFeature)
        case alert(AlertState<BoxesFeature.Action.Alert>)
    }
}
