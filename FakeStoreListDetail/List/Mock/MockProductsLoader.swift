//
//  MockProductsLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 26/09/24.
//

import Foundation

final class MockProductsLoader: ProductsLoader {
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        let items: [ProductItem] = [
            .init(id: 1, title: "Product 1", price: 10.0, desctiption: "Description 1", category: "Category 1", image: nil, rating: nil),
            .init(id: 2, title: "Product 2", price: 20.0, desctiption: "Description 2", category: "Category 2", image: nil, rating: nil),
            .init(id: 3, title: "Product 3", price: 30.0, desctiption: "Description 3", category: "Category 3", image: nil, rating: nil),
            .init(id: 4, title: "Product 4", price: 40.0, desctiption: "Description 4", category: "Category 4", image: nil, rating: nil),
        ]
        
        completion(.success(items))
    }
}
