//
//  LocalProductLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import Foundation


struct LocalProductItem {
    let id: Int
    let title: String
    let price: Double?
    let desctiption: String?
    let category: String?
    let imageURL: URL?
    let rating: LocalRatingItem?
}

struct LocalRatingItem: Decodable{
    let rate: Double
    let count: Int
}

//

protocol ProductStore {
    
    func deleteAll()
    func insert(_ products: [LocalProductItem], completion: @escaping (Result<Void, Error>) -> Void)
    func retrieve(completion: @escaping (Result<[LocalProductItem], Error>) -> Void)
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


//

final class UserDefaultsProductStore: ProductStore {
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: "products")
    }
    
    func insert(_ products: [LocalProductItem], completion: @escaping (Result<Void, Error>) -> Void) {
        
        UserDefaults.standard.set(products, forKey: "products")
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping (Result<[LocalProductItem],  Error>) -> Void) {
        
        let products: [LocalProductItem]? = UserDefaults.standard.array(forKey: "products") as? [LocalProductItem]
        completion(.success(products ?? []))
    }
   
}
