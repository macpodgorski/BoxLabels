//
//  ScanView.swift
//  BoxLabels
//
//  Created by Maciej Podgórski on 25/06/2024.
//

import CodeScanner
import SwiftUI

struct ScanView: View {
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "11111111-1111-1111-1111-111111111111", completion: handleScan)
    }

    func handleScan(result: Result<ScanResult, ScanError>) {

        switch result {
        case .success(let result):
            let details = result.string
            guard details.count == 1 else { return }

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ScanView()
}
