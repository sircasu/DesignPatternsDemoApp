//
//  UserDefaultsProductStore.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 02/10/24.
//

import Foundation

final class UserDefaultsProductStore: ProductStore {
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: "products")
    }
    
    func insert(_ products: [LocalProductItem], completion: @escaping (Result<Void, Error>) -> Void) {
        
        do {
            let encodedData = try JSONEncoder().encode(products)
            UserDefaults.standard.set(encodedData, forKey: "products")
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }

    }
    
    func retrieve(completion: @escaping (Result<[LocalProductItem],  Error>) -> Void) {
        
        if let savedData = UserDefaults.standard.object(forKey: "products") as? Data {

            do{

                let products = try JSONDecoder().decode([LocalProductItem].self, from: savedData)
                completion(.success(products))

            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "aa", code: 0)))
        }
    }
   
}
