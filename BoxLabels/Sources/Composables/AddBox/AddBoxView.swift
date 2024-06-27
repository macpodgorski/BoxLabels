//
//  AddBoxView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct AddBoxView: View {
    @Perception.Bindable var store: StoreOf<AddBoxFeature>

    var body: some View {
        let sizes = ["Small", "Medium", "Large"]

        Form {
            TextField("Title", text: $store.box.title.sending(\.setTitle))
            TextField("Description", text: $store.box.description.sending(\.setDescription))

            VStack(alignment: .leading) {
                Text("Choose box size")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Picker("Select box size", selection: $store.box.size.sending(\.setSize)) {
                    ForEach(sizes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }

            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddBoxView(
            store: Store(
                initialState: AddBoxFeature.State(
                    box: Box(id: UUID(),
                             title: "Title",
                             qrCode: UIImage().withRenderingMode(.alwaysOriginal),
                             description: "Desc",
                             size: "Medium",
                             boxItems: ["fdsfd", "fdsfds"]
                            )
                )
            ) {
                AddBoxFeature()
            }
        )
    }
}
