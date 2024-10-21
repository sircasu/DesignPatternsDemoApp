//
//  ProductsLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 18/09/24.
//

import Foundation

struct ProductItem {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let image: URL?
    let rating: RatingItem?
}

struct RatingItem {
    let rate: Double?
    let count: Int?
}

protocol ProductsLoader {
    typealias Result = Swift.Result<[ProductItem], Error>
    func loadProducts(completion: @escaping (Result) -> Void)
}
