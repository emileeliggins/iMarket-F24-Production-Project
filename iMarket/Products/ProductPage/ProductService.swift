//
//  ProductService.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import Foundation

struct ProductService {
    private static let session = URLSession.shared
    private static var decoder = JSONDecoder()
    
    public static func findProducts() async throws -> [Product] {
        //URL components instead of just URL to allow for additions to url
        let components = URLComponents(string: "https://dummyjson.com/products") //endpoint
        
        //checking url object created from the string
        guard let url = components?.url else { fatalError("Invalid URL") } //create custom errors to throw
        
        //performing a get request
        let (data, response) = try await session.data(from: url)
        
        //checking response code and handle
        guard let response = response as? HTTPURLResponse, response.statusCode == (200) else {
            fatalError("Invalid response") //create custom error to throw
        }
        
        return try decoder.decode(dummyResponse.self, from: data).products
    }
    
    public static func searchProducts(searchTerm: String) async throws -> [Product]{
        var components = URLComponents(string: "https://dummyjson.com/products/search")
        
        components?.queryItems = [URLQueryItem(name: "q", value: searchTerm)]
        
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            fatalError("Invalid response") //create custom error to throw
        }
        
        return try decoder.decode(dummyResponse.self, from: data).products
    }
}
