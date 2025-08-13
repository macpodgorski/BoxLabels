//
//  AlertState+deleteBox.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 13/08/2025.
//

import ComposableArchitecture

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
