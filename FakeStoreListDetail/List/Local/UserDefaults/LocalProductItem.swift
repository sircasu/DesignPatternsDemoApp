//
//  LocalProductItem.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 21/10/24.
//


import Foundation

// local product for userdefaults
public struct LocalProductItem: Equatable, Codable {
    let id: Int
    let title: String
    let price: Double?
    let description: String?
    let category: String?
    let imageURL: URL?
    let rating: LocalRatingItem?
    
    init(id: Int, title: String, price: Double?, description: String?, category: String?, imageURL: URL?, rating: LocalRatingItem?) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.imageURL = imageURL
        self.rating = rating
    }
}

public struct LocalRatingItem: Equatable, Codable {
    let rate: Double?
    let count: Int?
    
    init(rate: Double?, count: Int?) {
        self.rate = rate
        self.count = count
    }
}
