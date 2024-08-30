//
//  ProductViewModel.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/28/24.
//

import Foundation

enum searchLoadingStates{
    case idle //when there is no search term
    case loading //when there is a search term and looking for result
    case success(products: [Product]) //when received a response
    case noResult
    case error(error: Error)
}

@MainActor
class ProductViewModel: ObservableObject{
    
    @Published var products: [Product] = []
    @Published var searchTerm: String = ""
    @Published var state: searchLoadingStates = .idle
    
    
    func getDefaultProducts() async {
        do {
            products = try await ProductService.findProducts()
        } catch {
            print("No products")
        }
    }
    
    func searchProducts() async {
        if searchTerm.isEmpty {
            return
        }
        state = .loading
        do {
            let prods = try await ProductService.searchProducts(searchTerm: searchTerm)
            products = prods
        } catch {
            state = .error(error: error)
            print(error)
        }
    }
}
