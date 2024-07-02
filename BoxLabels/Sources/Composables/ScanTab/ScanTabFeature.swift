//
//  ScanTabFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 01/07/2024.
//

import Foundation
import ComposableArchitecture
import CodeScanner

extension AppFeature {
    @Reducer
    struct ScanTabFeature {
        @Reducer(state: .equatable)
        enum Destination {
            case detail(BoxDetailFeature)
        }

        @ObservableState
        struct State: Equatable {
            @Presents var destination: Destination.State?
            @Shared(.boxes) var boxes
            var readQrCode = ""
        }

        enum Action {
            case receivedQrCodeResult(Result<ScanResult, ScanError>)
            case destination(PresentationAction<Destination.Action>)
        }

        var body: some ReducerOf<Self> {
            Reduce { state, action in
                switch action {
                case .receivedQrCodeResult(.success(let result)):
                    state.readQrCode = result.string
                    if let matchedBox = state.boxes.first(where: { $0.id.uuidString == state.readQrCode }) {
                        state.destination = .detail(BoxDetailFeature.State(box: Shared(matchedBox)))
                    }
                    return .none

                case .receivedQrCodeResult(.failure(let error)):
                    print("Scanning failed: \(error.localizedDescription)")
                    return .none

                case .destination:
                    return .none
                }
            }
            .ifLet(\.$destination, action: \.destination)
        }
    }
}
