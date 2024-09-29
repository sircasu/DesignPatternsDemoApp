//
//  AFHTTPClient.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 27/09/24.
//

import Foundation
import Alamofire

class AFHTTPClient: HTTPClient {
    
    private struct UnexpectedValueRepresentation: Error {}

    func get(request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        
        AF.request(request).response { res in
        
            completion(Result {
                if let error = res.error {
                    throw error
                } else if let data = res.data, let response = res.response {
                    debugPrint(data)
                    return (data, response)
                } else {
                    throw UnexpectedValueRepresentation()
                }
            })
        }
    }
    

    
    
}
