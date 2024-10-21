//
//  LocalProductItem.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 21/10/24.
//


import Foundation

// local product for userdefaults
public struct LocalProductItem: Codable {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let imageURL: URL?
    let rating: LocalRatingItem?
}

public struct LocalRatingItem: Codable {
    let rate: Double?
    let count: Int?
}
