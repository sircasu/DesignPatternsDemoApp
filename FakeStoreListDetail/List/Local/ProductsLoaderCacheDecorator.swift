//
//  ProductsLoaderCacheDecorator.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 22/10/24.
//

import Foundation

public final class ProductsLoaderCacheDecorator: ProductsLoader {

    private let decoratee: ProductsLoader
    private let cache: ProductCache
    
    init(decoratee: ProductsLoader, cache: ProductCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void) {
        
        decoratee.loadProducts { [weak self] result in
            

            if let products = try? result.get() {
                self?.cache.save(products) { _ in }
            }
            
            completion(result)
        }
    }
    
}
