//
//  DummyResponse.swift
//  iMarket
//
//  Created by Emilee Liggins on 8/27/24.
//

import Foundation

struct dummyResponse: Codable{
    var products: [Product]
}

struct Review: Codable, Hashable {
    var rating: Int
    var comment: String
    var date: String
    var reviewerName: String
    var reviewerEmail: String
}

struct Product: Codable, Identifiable, Hashable{
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var thumbnail: String
    var reviews: [Review]
}
