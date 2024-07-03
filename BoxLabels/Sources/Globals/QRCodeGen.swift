//
//  QRCodeGen.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

func generateQRCode(from string: String) -> Data? {
    let filter = CIFilter.qrCodeGenerator()

    guard let data = string.data(using: .ascii, allowLossyConversion: false)
    else { return nil }
    filter.message = data

    guard let ciImage = filter.outputImage else { return nil }
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledImage = ciImage.transformed(by: transform)
    let uiImage = UIImage(ciImage: scaledImage)

    return uiImage.pngData()

}
