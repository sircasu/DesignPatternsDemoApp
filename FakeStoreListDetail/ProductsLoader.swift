//
//  ProductsLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 18/09/24.
//

import Foundation

protocol ProductsLoader {
    typealias Result = Swift.Result<[ProductItem], Error>
    func loadProducts(completion: @escaping (Result) -> Void)
}
