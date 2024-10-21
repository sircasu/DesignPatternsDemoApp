//
//  ProductStore.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

public typealias CachedProducts = (products: [LocalProductItem], timestamp: Date)

protocol ProductStore {
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<CachedProducts?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    func deleteAll()
    func insert(_ products: [LocalProductItem], timestamp: Date, completion: @escaping (InsertionCompletion))
    func retrieve(completion: @escaping RetrievalCompletion)
}
