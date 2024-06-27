//
//  Box.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 04/05/2024.
//

import Foundation
import UIKit

struct Box: Identifiable, Equatable {
    let id: UUID
    var title: String
    let qrCode: UIImage?
    var description: String
    var size: String
    var boxItems: [String]
}
