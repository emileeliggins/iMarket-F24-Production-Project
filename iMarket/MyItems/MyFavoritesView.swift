//
//  MyFavoritesView.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import SwiftUI

struct MyFavoritesView: View {
    @EnvironmentObject var favorites: MyItems

    var body: some View {
        NavigationStack {
            ZStack{
                if favorites.likedItems.isEmpty{
                    noFavoritesView
                } else {
                    showFavorites
                }
            }
            .navigationTitle("My Items")
        }
    }
    
    
    @ViewBuilder
    private var noFavoritesView: some View{
        Spacer()
        
        ZStack {
            VStack {
                Image(systemName: "heart.square.fill")
                    .foregroundStyle(.gray)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text("No favorite items")
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(alignment: .center)
                Text("Click the heart on products you like!")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    @ViewBuilder
    private var showFavorites: some View{
        ScrollView{
            VStack {
                ForEach(favorites.likedItems, id: \.id) { product in
                    ProductItem(product: product)
                }
            }
        }
        
    }
    
}

// #Preview {
//    MyFavoritesView()
// }
