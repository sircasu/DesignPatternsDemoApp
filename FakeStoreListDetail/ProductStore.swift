//
//  ProductStore.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

struct LocalProductItem: Codable {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let imageURL: URL?
    let rating: LocalRatingItem?
}

struct LocalRatingItem: Codable {
    let rate: Double?
    let count: Int?
}

protocol ProductStore {
    
    func deleteAll()
    func insert(_ products: [LocalProductItem], completion: @escaping (Result<Void, Error>) -> Void)
    func retrieve(completion: @escaping (Result<[LocalProductItem], Error>) -> Void)
}
