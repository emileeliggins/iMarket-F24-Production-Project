//
//  MyItemsModel.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/29/24.
//

import Foundation

class MyItems: ObservableObject{
    @Published var likedItems: [Product] = []
    
    func addProduct(_ product: Product) {
        if !likedItems.contains(where: { $0.id == product.id }) {
            likedItems.append(product)
        }
    }

    func removeProduct(_ product: Product) {
        likedItems.removeAll { $0.id == product.id }
    }

    func isProductLiked(_ product: Product) -> Bool {
        likedItems.contains(where: { $0.id == product.id })
    }
}
