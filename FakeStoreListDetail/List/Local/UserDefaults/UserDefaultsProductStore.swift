//
//  UserDefaultsProductStore.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

final class UserDefaultsProductStore: ProductStore {
    
    private struct Cache: Codable {
        let products: [LocalProductItem]
        let timestamp: Date
        
        var localProducts: [LocalProductItem] {
            return products.map { LocalProductItem(id: $0.id, title: $0.title, price: $0.price, description: $0.description, category: $0.category, imageURL: $0.imageURL, rating: LocalRatingItem(rate: $0.rating?.rate, count: $0.rating?.count)) }
        }
    }
    
    func deleteAll(completion: @escaping DeletionCompletion) {
        UserDefaults.standard.removeObject(forKey: "products")
        completion(.success(()))
    }
    
    func insert(_ products: [LocalProductItem], timestamp: Date, completion: @escaping (InsertionCompletion)) {
        
        do {
            let cache = Cache(products: products, timestamp: timestamp)
            let encodedData = try JSONEncoder().encode(cache)
            UserDefaults.standard.set(encodedData, forKey: "products")
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }

    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        
        if let savedData = UserDefaults.standard.object(forKey: "products") as? Data {

            do{

                let cache = try JSONDecoder().decode(Cache.self, from: savedData)
//                completion(.success(products))
                let cachedProducts = CachedProducts(products: cache.localProducts, timestamp: cache.timestamp)
                completion(.success(cachedProducts))

            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "aa", code: 0)))
        }
    }
   
}
