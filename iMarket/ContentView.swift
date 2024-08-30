//
//  ContentView.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var cart = MyCart()
    @StateObject var likedItems = MyItems()
    
    var body: some View {
            TabView{
                ProductPageView()
                    .tabItem { Label("Products", systemImage: "carrot.fill") }
                
                MyFavoritesView()
                    .tabItem { Label("My Items", systemImage: "heart.fill") }
                
                MyCartView()
                    .tabItem { Label("My Cart", systemImage: "cart.fill")
                    }
                    .badge(cart.items.count)
            }
            .environmentObject(cart)
            .environmentObject(likedItems)
    }
}

#Preview {
    ContentView()
}
