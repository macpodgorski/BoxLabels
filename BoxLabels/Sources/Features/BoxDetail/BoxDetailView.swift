//
//  BoxDetailView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 26/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct BoxDetailView: View {
    @Perception.Bindable var store: StoreOf<BoxDetailFeature>

    var body: some View {
        Form {
            Section {
                if let uiImage = UIImage(data: store.box.qrCode) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .contextMenu {
                            ShareLink(
                                item: Image(uiImage: uiImage),
                                preview: SharePreview(
                                    "\(store.box.title) QR Code",
                                    image: Image(uiImage: uiImage)
                                )
                            )
                        }
                        .padding(.leading)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)

            Section {
                HStack {
                    Label("Room", systemImage: "door.left.hand.open")
                    Spacer()
                    Text(store.box.room)
                }
                HStack {
                    Label("Size", systemImage: "square.resize.up")
                    Spacer()
                    Text(store.box.size)
                }
            } header: {
                Text("Box info")
            }

            if !store.box.boxItems.isEmpty {
                Section {
                    ForEach(store.box.boxItems) { item in
                        Label(item.title, systemImage: "archivebox")
                    }
                } header: {
                    Text("Items")
                }
            }
        }
        .navigationTitle(Text(store.box.title))
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
        .toolbar {
            Button {
                store.send(.deleteButtonTapped)
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.red)
            }
            Button("Edit") {
                store.send(.editButtonTapped)
            }
        }
        .sheet(item: $store.scope(state: \.destination?.edit, action: \.destination.edit) ) { editBoxStore in
            NavigationStack {
                BoxFormView(store: editBoxStore)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                store.send(.cancelEditButtonTapped)
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                store.send(.saveEditButtonTapped)
                            }
                        }
                    }
            }
        }
    }

}

#Preview {
  NavigationStack {
    BoxDetailView(
      store: Store(
        initialState: BoxDetailFeature.State(
          box: Shared(.mock)
        )
      ) {
        BoxDetailFeature()
      }
    )
  }
}
