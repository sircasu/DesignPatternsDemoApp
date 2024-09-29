//
//  MainQueueDecorators.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import Foundation

final class MainQueueDispatchDecorator<T> {

    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {

        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}


extension MainQueueDispatchDecorator: ProductsLoader where T == ProductsLoader {
   
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        decoratee.loadProducts { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
