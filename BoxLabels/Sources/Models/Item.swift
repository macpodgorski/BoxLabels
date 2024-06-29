//
//  Item.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 27/06/2024.
//

import Foundation

struct Item: Identifiable, Equatable, Codable {
    let id: UUID
    var title = ""
}
