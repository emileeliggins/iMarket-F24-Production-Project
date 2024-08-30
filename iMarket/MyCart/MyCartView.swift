//
//  MyCartView.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import SwiftUI

struct MyCartView: View {
    @EnvironmentObject var cartItems: MyCart
    @StateObject var vm = MyCartViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Menu{
                        Button("Pick up"){
                            vm.mode = "Pick up"
                        }
                        Button("Delivery"){
                            vm.mode = "Delivery"
                        }
                    } label:{
                        Text("\(vm.mode)")
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.down")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.primary)
                    
                   
                    Text("from")
                        .foregroundStyle(.gray)
                    Text("Cupertino")
                        .fontWeight(.semibold)
                        .underline()
                    Spacer()
                }
                
                
                if cartItems.items.isEmpty{
                    emptyCartView
                } else {
                    showCart
                }
                
               
                
            }
            .padding(.horizontal)
            .navigationTitle("Cart")
        }
    }
    
    @ViewBuilder
    private var emptyCartView: some View{
        Spacer()
        ZStack {
            VStack {
                Image(systemName: "cart.badge.questionmark")
                    .foregroundStyle(.gray)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text("No items in your cart")
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(alignment: .center)
                Text("Press 'Add to Cart' to fill your cart! ")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        Spacer()
    }
    
    @ViewBuilder
    private var showCart: some View{
        List {
            ForEach(cartItems.items, id: \.id) { product in
                cartItem(product: product)
            }
            .onDelete(perform: { indexSet in
                vm.deleteItems(at: indexSet, cartItems: cartItems)
            })
        }
        .listStyle(.plain)
        
        Spacer()
        
        
        Button {} label: {
            HStack{
                Text("Check out")
                    .padding(8.0)
                    .cornerRadius(20.0)
                    .foregroundColor(.primary)
                    
                    
            }
            .frame(width: 350, height: 36)
            .background(Color.blue)
            .cornerRadius(20.0)
        }
        .padding(.bottom)
        
    }
}

// #Preview {
//    MyCartView()
// }

struct cartItem: View {
    var product: Product
    
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: URL(string: product.thumbnail), scale: 7.0)
                
                Text("\(product.title)")
                    .truncationMode(.tail)
                    .lineLimit(1)
                    .frame(maxWidth: 180, alignment: .leading)
            }
            
            Spacer()
            Text(String(format: "$%.2f", product.price))
                .fontWeight(.bold)
        }
    }
}
