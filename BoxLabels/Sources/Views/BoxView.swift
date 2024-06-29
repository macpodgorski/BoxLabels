//
//  BoxView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 28/06/2024.
//

import SwiftUI

struct BoxView: View {
    let box: Box

    var body: some View {
        ZStack {
            // Main front face of the box
            Rectangle()
                .fill(Color.brown)
                .frame(width: 200, height: 200)
                .shadow(color: .gray, radius: 5, x: 5, y: 5)

            VStack {
                Image(uiImage: UIImage(data: box.qrCode)!)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)

                Text(box.title)
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    BoxView(box: Box(id: UUID(), title: "bofsdasdffsdx 1", qrCode: generateQRCode(from: "text")))
}
