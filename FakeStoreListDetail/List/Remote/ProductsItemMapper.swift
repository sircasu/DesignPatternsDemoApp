//
//  ProductsItemMapper.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 26/09/24.
//

import Foundation

struct RemoteProductItem: Decodable {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let image: URL?
    let rating: RemoteRatingItem?
}

struct RemoteRatingItem: Decodable{
    let rate: Double
    let count: Int
}

final class ProductsItemMapper {

    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteProductItem] {
        guard response.statusCode == 200, let items = try? JSONDecoder().decode([RemoteProductItem].self, from: data) else {
            throw RemoteProductsLoader.Error.invalidData
        }
        
        return items
    }
}
