//
//  Box.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 04/05/2024.
//

import Foundation
import IdentifiedCollections
import SwiftUI
import ComposableArchitecture

struct Box: Identifiable, Equatable, Codable {
    let id: UUID
    var title = ""
    var boxItems: IdentifiedArrayOf<Item> = []
    var qrCode: Data = Data()
    var room = "Bedroom"
    var size = "Medium"

    init(id: UUID, title: String = "", boxItems: IdentifiedArrayOf<Item> = [],
         qrCode: UIImage, room: String = "", size: String = "") {
        self.id = id
        self.title = title
        self.boxItems = boxItems
        self.qrCode = qrCode.pngData()!
        self.room = room
        self.size = size
    }
}

extension Box {
  static let mock = Box(
    id: Box.ID(),
    title: "Box 1",
    boxItems: [
      Item(id: Item.ID(), title: "item1"),
      Item(id: Item.ID(), title: "item2"),
      Item(id: Item.ID(), title: "item3")],
    qrCode: generateQRCode(from: "blank qr"),
    room: "Bedroom",
    size: "Medium"
  )
}
