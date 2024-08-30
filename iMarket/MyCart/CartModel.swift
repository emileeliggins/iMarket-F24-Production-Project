//
//  CartModel.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/29/24.
//

import Foundation

class MyCart: ObservableObject {
    @Published var items: [Product] = []

    func addProduct(_ product: Product) {
        if !items.contains(where: { $0.id == product.id }) {
            items.append(product)
        }
    }

    func removeProduct(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    func isProductInCart(_ product: Product) -> Bool {
        items.contains(where: { $0.id == product.id })
    }
}
