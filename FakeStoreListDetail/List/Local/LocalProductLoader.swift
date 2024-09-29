//
//  LocalProductLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import Foundation


struct LocalProductItem: Codable {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let imageURL: URL?
    let rating: LocalRatingItem?
}

struct LocalRatingItem: Codable {
    let rate: Double?
    let count: Int?
}

//

protocol ProductStore {
    
    func deleteAll()
    func insert(_ products: [LocalProductItem], completion: @escaping (Result<Void, Error>) -> Void)
    func retrieve(completion: @escaping (Result<[LocalProductItem], Error>) -> Void)
}


protocol ProductCache {
    func save(_ products: [ProductItem], completion: @escaping (Result<Void, Error>) -> Void)
}
//

final class LocalProductLoader {
    
    private let productStore: ProductStore
    
    init(productStore: ProductStore) {
        self.productStore = productStore
    }
    
}

extension LocalProductLoader: ProductsLoader {
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        productStore.retrieve { res in
            
            switch res {
            case let .success(localProducsItem):
                completion(.success(localProducsItem.toModels()))
                break
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension LocalProductLoader: ProductCache {
    func save(_ products: [ProductItem], completion: @escaping (Result<Void, Error>) -> Void) {
        
        productStore.insert(products.toLocal()) { res in
            completion(res)
        }
    }
    
    
}


private extension Array where Element == LocalProductItem {
    func toModels() -> [ProductItem] {
        return map {
            
            ProductItem(
                id: $0.id,
                title: $0.title,
                price: $0.price,
                desctiption: $0.desctiption,
                category: $0.category,
                image: $0.imageURL,
                rating: RatingItem(
                    rate: $0.rating?.rate,
                    count: $0.rating?.count)
            )
        }
    }
}

private extension Array where Element == ProductItem {
    func toLocal() -> [LocalProductItem] {
        return map {
            
            LocalProductItem(
                id: $0.id,
                title: $0.title,
                price: $0.price,
                desctiption: $0.desctiption,
                category: $0.category,
                imageURL: $0.image,
                rating: LocalRatingItem(
                    rate: $0.rating?.rate,
                    count: $0.rating?.count)
                )
        }
    }
}


//

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
        }
    }
   
}
