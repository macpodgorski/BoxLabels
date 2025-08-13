//
//  CardView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct CardView: View {
  let box: Box

  var body: some View {
    HStack {
        if let uiImage = UIImage(data: box.qrCode) {
            Image(uiImage: uiImage)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
                .padding(.trailing, 10)
        } else {
            Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
        }

        Text(box.title)
            .font(.title)
            .foregroundStyle(.white)
    }
    .padding(5)
  }
}

#Preview {
    CardView(box: Box(id: UUID(), title: "bofsdasdffsdx 1", qrCode: Data()))
}
