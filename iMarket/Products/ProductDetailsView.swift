//
//  ProductDetailsView.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/29/24.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var cartProducts: MyCart
    @EnvironmentObject var likedItems: MyItems
    @State var product: Product
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                    HStack {
                        Image(systemName: "star")
                            .font(.caption)
                        Image(systemName: "star")
                            .font(.caption)
                        Image(systemName: "star")
                            .font(.caption)
                        Image(systemName: "star")
                            .font(.caption)
                        Image(systemName: "star")
                            .font(.caption)
                        
                        Text("(3)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                    
                    AsyncImage(url: URL(string: product.thumbnail))
                    
                    HStack {
                        Text(String(format: "$%.2f", product.price))
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("In Stock")
                            .foregroundStyle(.green)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("at")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text("Cupertino")
                            .foregroundStyle(.primary)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .underline()
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .center, spacing: 16) {
                        Button(action: {
                            cartProducts.addProduct(product)
                        }) {
                            Text("Add to Cart")
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 310, height: 36)
                                .background(Color.blue)
                                .cornerRadius(18.0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            if likedItems.isProductLiked(product) {
                                likedItems.removeProduct(product)
                            } else {
                                likedItems.addProduct(product)
                            }
                        }) {
                            Image(systemName: likedItems.isProductLiked(product) ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(9)
                                .background(.categoryBackground)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Description")
                            .font(.title3)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(product.description)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Reviews")
                            .font(.title3)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.caption)
                            
                            Text("Sort")
                                .font(.caption)
                        }
                        .padding(5)
                        .background(.categoryBackground)
                        .cornerRadius(5.0)
                    }
                    .padding(.bottom)
                    
                    VStack {
                        HStack {
                            Text("Charlotte Lopez")
                                .font(.callout)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("May 5, 2024")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Image(systemName: "star")
                                .font(.caption)
                            Image(systemName: "star")
                                .font(.caption)
                            Image(systemName: "star")
                                .font(.caption)
                            Image(systemName: "star")
                                .font(.caption)
                            Image(systemName: "star")
                                .font(.caption)
                            
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Text("Highly reccommend!")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(product.title)
            }
        }
    }
}

// #Preview {
//    ProductDetailsView()
// }
