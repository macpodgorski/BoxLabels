//
//  AppFeature.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    @Reducer(state: .equatable)
    enum Path {
        case detail(BoxDetailFeature)
    }
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var boxesList = BoxesListFeature.State()
    }
    enum Action {
        case path(StackActionOf<Path>)
        case boxesList(BoxesListFeature.Action)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.boxesList, action: \.boxesList) {
            BoxesListFeature()
        }
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            case .boxesList:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
