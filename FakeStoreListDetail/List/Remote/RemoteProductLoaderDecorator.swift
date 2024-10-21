//
//  RemoteProductLoaderDecorator.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation


final class RemoteProductLoaderDecorator: ProductsLoader {

    private let decoratee: ProductsLoader
    private let cache: ProductCache
    
    init(decoratee: ProductsLoader, cache: ProductCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void) {
        
        decoratee.loadProducts { [weak self] result in
            
//            completion(result.map { products in
//                self?.cache.save(products) { _ in }
//                return products
//            })
            guard let self = self else { return }
            
            switch result {

            case .success(let products):
                cache.save(products) { _ in }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    
}
