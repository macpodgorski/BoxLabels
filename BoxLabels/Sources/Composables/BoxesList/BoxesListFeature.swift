//
//  BoxesListFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BoxesListFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var addBox: BoxFormFeature.State?
        @Shared(.boxes) var boxes
    }
    enum Action {
        case addBoxButtonTapped
        case addBox(PresentationAction<BoxFormFeature.Action>)
        case cancelButtonTapped
        case confirmButtonTapped
        case onDelete(IndexSet)
        case boxTapped(id: Box.ID)
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addBoxButtonTapped:
                let id = Box.ID()
                state.addBox = BoxFormFeature.State(
                    box: Box(id: id,
                            qrCode: generateQRCode(from: id.uuidString)!,
                            room: "Living Room",
                            size: "Small")
                )
                // TODO: make qrcode from id and username in future
                return .none

            case .addBox:
                return .none

            case .confirmButtonTapped:
                guard let newBox = state.addBox?.box
                else { return .none }
                state.addBox = nil
                state.boxes.append(newBox)
                return .none

            case .cancelButtonTapped:
                state.addBox = nil
                return .none

            case let .onDelete(indexSet):
                state.boxes.remove(atOffsets: indexSet)
                return .none

            case .boxTapped:
                return .none
            }
        }
        .ifLet(\.$addBox, action: \.addBox) {
            BoxFormFeature()
        }
    }
}

