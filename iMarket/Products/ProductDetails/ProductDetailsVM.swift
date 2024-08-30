//
//  ProductDetailsVM.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/30/24.
//

import Foundation

class ProductDetailsVM: ObservableObject {
    func formatDate(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        outputFormatter.timeStyle = .none
        
        return outputFormatter.string(from: date)
    }
}
