//
//  RemoteProductsLoader.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 26/09/24.
//

import Foundation

final class RemoteProductsLoader: ProductsLoader {
    
    private let httpClient: HTTPClient?
    
    init(httpClient: HTTPClient?) {
        self.httpClient = httpClient
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void) {
        
        let request = URLRequest(url: URL(string: "https://fakestoreapi.com/products")!)
        httpClient?.get(request: request) { res in
            
            switch res {
            case let .success((data, response)):
                completion(RemoteProductsLoader.map(data, from: response))
                break
            case .failure:
                completion(.failure(RemoteProductsLoader.Error.connectivity))
                break
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> ProductsLoader.Result {
        do {
            let products = try ProductsItemMapper.map(data, from: response)
            return .success(products.toItems)
        } catch {
           return  .failure(RemoteProductsLoader.Error.connectivity)
        }
    }
}


private extension Array where Element == RemoteProductItem {
    
    var toItems: [ProductItem] {
        map { ProductItem(id: $0.id, title: $0.title, price: $0.price, desctiption: $0.desctiption, category: $0.category, image: $0.image, rating: RatingItem(rate: nil, count: nil)) }
    }
}
