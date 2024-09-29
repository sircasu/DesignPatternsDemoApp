//
//  MainQueueDispatchProductsLoaderDecorator.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//

import Foundation

final class MainQueueDispatchProductsLoaderDecorator: ProductsLoader {
    
    let decoratee: ProductsLoader
    
    init(decoratee: ProductsLoader) {
        self.decoratee = decoratee
    }
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        decoratee.loadProducts { res in

            guard Thread.isMainThread else {
                return DispatchQueue.main.async {
                    completion(res)
                }
            }
            
            completion(res)

        }
    }
}
