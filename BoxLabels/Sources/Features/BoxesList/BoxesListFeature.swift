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
    }

    @Dependency(\.qrCodeGenerator) var qrCodeGenerator

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addBoxButtonTapped:
                let id = Box.ID()
                guard let qrCodeData = qrCodeGenerator.generateQRCode(from: id.uuidString) else {
                    print("Error: Unable to generate QR code")
                    return .none
                }
                state.addBox = BoxFormFeature.State(
                    box: Box(id: id,
                            qrCode: qrCodeData,
                            room: "Living Room",
                            size: "Small")
                )
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
            }
        }
        .ifLet(\.$addBox, action: \.addBox) {
            BoxFormFeature()
        }
    }
}
