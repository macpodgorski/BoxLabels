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
                Image(uiImage: UIImage(data: store.box.qrCode)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(
                            item: Image(uiImage: UIImage(data: store.box.qrCode)!),
                            preview: SharePreview(
                                "\(store.box.title) QR Code",
                                image: Image(uiImage: UIImage(data: store.box.qrCode)!)
                            )
                        )
                    }
                HStack {
                    Label("Room", systemImage: "text.alignleft")
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

            Section {
                ForEach(store.box.boxItems) { item in
                    Label(item.title, systemImage: "archivebox")
                }
            } header: {
                Text("Items")
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
                    .navigationTitle(store.box.title)
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
