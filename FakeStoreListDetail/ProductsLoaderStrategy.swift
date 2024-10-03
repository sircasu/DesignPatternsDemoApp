//
//  ProductsLoaderStrategy.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

class ProductsLoaderStrategy: ProductsLoader {
    private let primary: ProductsLoader
    private let fallback: ProductsLoader
    
    init(primary: ProductsLoader, fallback: ProductsLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        primary.loadProducts { [weak self] result in
            
            switch result {
            case .success:
                print("(primary) from local")
                completion(result)
            case .failure:
                print("(fallback) from remote")
                self?.fallback.loadProducts(completion: completion)
            }
        }
    }
    
}
