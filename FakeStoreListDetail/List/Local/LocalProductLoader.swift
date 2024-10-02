//
//  LocalProductLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import Foundation


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
