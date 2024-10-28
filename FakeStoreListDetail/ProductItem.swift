//
//  ProductItem.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 22/10/24.
//

import Foundation

struct ProductItem {
    let id: Int
    let title: String
    let price: Double?
    let description: String?
    let category: String?
    let image: URL?
    let rating: RatingItem?
}

struct RatingItem {
    let rate: Double?
    let count: Int?
}
