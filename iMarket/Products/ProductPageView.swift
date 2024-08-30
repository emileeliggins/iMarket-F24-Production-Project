//
//  ProductPageView.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import SwiftUI

struct ProductPageView: View {
    @StateObject private var vm = ProductViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.headline)
                        .padding(.trailing, 5)
                    TextField("What are you looking for?", text: $vm.searchTerm)
                        .autocorrectionDisabled(true)
                        .onSubmit {
                            vm.state = vm.products.isEmpty ? .noResult : .success(products: vm.products)
                        }
                        .overlay(
                            HStack {
                                Spacer()
                                if !vm.searchTerm.isEmpty {
                                    Button(action: {
                                        vm.searchTerm = ""
                                        vm.state = .idle
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.trailing, 8)
                                }
                            }
                        )
                }
                .frame(height: 36)
                .padding(.horizontal)
                .background(.categoryBackground)
                .cornerRadius(20.0)
                .padding(.horizontal)

                Divider()
                    .padding(.top)
                    .padding(.bottom, 0)

                switch vm.state {
                case .idle:
                    idleView
                case .loading:
                    loadingView
                case .success(products: let products):
                    successView(products)
                case .error(error: let error):
                    errorView(error)
                case .noResult:
                    noResultView
                }
            }

            .task(id: vm.searchTerm) {
                if vm.searchTerm.isEmpty {
                    await vm.getDefaultProducts()

                } else {
                    await vm.searchProducts()
                }
            }
        }
    }

    @ViewBuilder
    private var idleView: some View {
        ScrollView {
            VStack {
                ForEach(vm.products, id: \.id) { product in
                    ProductItem(product: product)
                }
            }
        }
    }

    @ViewBuilder
    private var loadingView: some View {
        VStack {
            Text("Loading")
        }
        Spacer()
    }

    @ViewBuilder
    private func successView(_ products: [Product]) -> some View {
        ScrollView {
            VStack {
                ForEach(products, id: \.id) { product in
                    ProductItem(product: product)
                }
            }
        }
    }

    @ViewBuilder
    private var noResultView: some View {
        Spacer()
        
        ZStack {
            VStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text("No Results")
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .font(.title2)
                Text("Check the spelling or try a new search.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        
        Spacer()
    }

    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Text("Error: \(error)")
        Spacer()
    }
}

// #Preview {
//    ProductPageView()
// }

struct ProductItem: View {
    @State var product: Product
    @EnvironmentObject var cartProducts: MyCart
    @EnvironmentObject var likedItems: MyItems

    var body: some View {
        NavigationStack {
            
            NavigationLink {
                ProductDetailsView(product: product)
            } label: {
                HStack {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.image?.resizable().scaledToFit().frame(width: 128, height: 128)
                    }

                    VStack(alignment: .leading) {
                        Text(product.title)
        //                    .foregroundStyle(Color.white)
                            .font(.title3)

                        Text(String(format: "$%.2f", product.price))
                            .font(.title2)
                            .fontWeight(.bold)
        //                    .foregroundStyle(Color.white)

                        Text(product.category.localizedCapitalized)
                            .padding(4)
                            .background(.categoryBackground)
        //                    .foregroundStyle(Color.white)
                            .cornerRadius(3.0)

                        HStack {
                            Button {
                                cartProducts.addProduct(product)
                            } label: {
                                Text("Add to Cart")
                                    .padding(.vertical, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal, 40)
                                    .foregroundColor(.primary)
                                    .background(Color.blue)
                                    .cornerRadius(20.0)
                            }

                            Button {
                                if likedItems.isProductLiked(product) {
                                    likedItems.removeProduct(product)
                                } else {
                                    likedItems.addProduct(product)
                                }
                            } label: {
                                VStack(alignment: .center) {
                                    Image(systemName: likedItems.isProductLiked(product) ? "heart.fill" : "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        //                            .foregroundStyle(Color.white)
                                        .padding(11)
                                        .background(.categoryBackground)
                                        .cornerRadius(30.0)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(width: 361, height: 128)
                .padding()
            }
            .buttonStyle(.plain)

            
           
        }
        
    }
}
