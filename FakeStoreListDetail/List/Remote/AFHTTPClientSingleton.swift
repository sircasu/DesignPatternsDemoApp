//
//  AFHTTPClientSingleton.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//

import Foundation
import Alamofire

class AFHTTPClientSingleton: HTTPClient {

    static let shared = AFHTTPClientSingleton()
    
    private struct UnexpectedValueRepresentation: Error {}
    
    func get(request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        
        AF.request(request).response { res in
            
            if let error = res.error {
                completion(HTTPClient.Result.failure(error))
                return
            }
            
            if let data = res.data, let response = res.response {
                completion(HTTPClient.Result.success((data, response)))
                return
            }
            
            completion(.failure(UnexpectedValueRepresentation()))
        }
    }
}
