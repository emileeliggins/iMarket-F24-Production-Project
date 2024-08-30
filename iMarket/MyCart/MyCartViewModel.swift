//
//  MyCartViewModel.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/29/24.
//

import Foundation


class MyCartViewModel: ObservableObject{
    
    @Published var mode = "Pick up"
    
    func deleteItems(at offsets: IndexSet, cartItems: MyCart) {
            for index in offsets {
                let product = cartItems.items[index]
                cartItems.removeProduct(product)
            }
    }
}
