//
//  ScanTabView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import CodeScanner
import SwiftUI
import ComposableArchitecture

struct ScanTabView: View {
    @Perception.Bindable var store: StoreOf<AppFeature.ScanTabFeature>

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.brown)
            CodeScannerView(codeTypes: [.qr], simulatedData: "642E301D-144C-48EF-88CD-DD609EB8A166") { result in
                store.send(.receivedQrCodeResult(result))
            }
            .sheet(item: $store.scope(state: \.destination?.detail, action: \.destination.detail) ) { detailBoxStore in
                NavigationStack {
                    BoxDetailView(store: detailBoxStore)
                        .navigationTitle(detailBoxStore.box.title)
                }
            }
        }
        .padding(.all, 10)
    }
}
