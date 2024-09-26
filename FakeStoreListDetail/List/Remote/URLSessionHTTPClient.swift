//
//  URLSessionHTTPClient.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 26/09/24.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValueRepresentation: Error {}
    
    func get(request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: request) { data, response, error in

            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                }
                else {
                    throw UnexpectedValueRepresentation()
                }
            })
        }.resume()
    }

}
