//
//  LocalProductLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import Foundation


final class LocalProductLoader {
    
    private let productStore: ProductStore
    private let currentDate: () -> Date
    
    init(productStore: ProductStore, currentDate: @escaping () -> Date) {
        self.productStore = productStore
        self.currentDate = currentDate
    }
    
}

extension LocalProductLoader: ProductsLoader {
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void) {
        
        productStore.retrieve { [weak self] res in
            
            guard let self = self else { return }
            
            switch res {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(cache)) where ProductsCachePolicy.validate(cache.timestamp, against: self.currentDate()):
                completion(.success(cache.products.toModels()))

            case .success:
//                completion(.success([]))
                completion(.failure(NSError(domain: "asd", code: 0)))

            }
            
        }
    }
}

extension LocalProductLoader: ProductCache {
    func save(_ products: [ProductItem], completion: @escaping (Result<Void, Error>) -> Void) {
        
        productStore.deleteAll { [weak self] deletionResult in
            
            guard let self = self else { return }
            
            switch deletionResult {
            case .success:
                productStore.insert(products.toLocal(), timestamp: self.currentDate()) { [weak self] error in
                    
                    guard self != nil else { return }
                    completion(error)
                }
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
                description: $0.description,
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
                description: $0.description,
                category: $0.category,
                imageURL: $0.image,
                rating: LocalRatingItem(
                    rate: $0.rating?.rate,
                    count: $0.rating?.count)
                )
        }
    }
}
