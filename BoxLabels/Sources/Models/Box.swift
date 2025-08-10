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

    static let allSizes = ["Small", "Medium", "Large"]
    static let allRooms = ["Living Room", "Bedroom", "Hallway", "Garage", "Attic", "Kitchen", "Bathroom", "Other"]
}

extension Box {
  static let mock = Box(
    id: Box.ID(),
    title: "Box 1",
    boxItems: [
      Item(id: Item.ID(), title: "item1"),
      Item(id: Item.ID(), title: "item2"),
      Item(id: Item.ID(), title: "item3")],
    qrCode: generateQRCode(from: "blank qr")!,
    room: "Bedroom",
    size: "Medium"
  )
}
