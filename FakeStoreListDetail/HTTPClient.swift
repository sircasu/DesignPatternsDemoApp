//
//  HTTPClient.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 26/09/24.
//

import Foundation

protocol HTTPClient {
    
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func get(request: URLRequest, completion: @escaping (Result) -> Void)
}

