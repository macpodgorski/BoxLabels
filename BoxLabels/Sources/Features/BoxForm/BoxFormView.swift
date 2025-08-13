//
//  BoxFormView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct BoxFormView: View {
    @Perception.Bindable var store: StoreOf<BoxFormFeature>
    @FocusState var focus: BoxFormFeature.State.Field?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Form {
                Section {
                    TextField("Title", text: $store.box.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .focused($focus, equals: .title)

                    Picker("Room", selection: $store.box.room) {
                        ForEach(Box.allRooms, id: \.self) {
                            Text($0)
                        }
                    }

                    Picker("Size", selection: $store.box.size) {
                        ForEach(Box.allSizes, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Box info")
                }
                Section {
                    ForEach($store.box.boxItems) { $item in
                        TextField("Name", text: $item.title)
                            .focused($focus, equals: .item(item.id))
                    }
                    .onDelete { indices in
                        store.send(.onDeleteItems(indices))
                    }

                } header: {
                    Text("Items")
                }
            }
            Button {
                store.send(.addItemButtonTapped)
            } label: {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .padding(.trailing, 30)
        }
        .bind($store.focus, to: $focus)
    }

}

#Preview {
  BoxFormView(
    store: Store(
      initialState: BoxFormFeature.State(
        box: .mock
      )
    ) {
      BoxFormFeature()
    }
  )
}
