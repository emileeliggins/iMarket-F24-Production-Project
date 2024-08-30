//
//  MyCartViewModel.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/29/24.
//

import Foundation

struct Price {
    var total: Double
    var tax: Double
}

class MyCartViewModel: ObservableObject {
    @Published var mode = "Pick up"
    @Published var expandPrice = false
    @Published var showAlert = false
    @Published var tyMessage = "Thank you for your purchase, payment options will be sent via email!"

    func calcPrice(items: [Product], tax: Double) -> Price {
        var total = 0.00
        for item in items {
            total += item.price
        }
        let totalTax = total * tax
        total += totalTax
        return Price(total: total, tax: totalTax)
    }

    func deleteItems(at offsets: IndexSet, cartItems: MyCart) {
        for index in offsets {
            let product = cartItems.items[index]
            cartItems.removeProduct(product)
        }
    }

    func checkOut(cartItems: MyCart) {
        let itemsToRemove = cartItems.items

        for item in itemsToRemove {
            cartItems.removeProduct(item)
        }
    }
}
