//
//  DependencyValues+qrCodeGenerator.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 13/08/2025.
//
import ComposableArchitecture

private enum QRCodeGeneratorKey: DependencyKey {
    static let liveValue = QRCodeGenerator()
}

extension DependencyValues {
    var qrCodeGenerator: QRCodeGenerator {
        get { self[QRCodeGeneratorKey.self] }
        set { self[QRCodeGeneratorKey.self] = newValue }
    }
}
