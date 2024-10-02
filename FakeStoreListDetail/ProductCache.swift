//
//  ProductCache.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

protocol ProductCache {
    func save(_ products: [ProductItem], completion: @escaping (Result<Void, Error>) -> Void)
}
