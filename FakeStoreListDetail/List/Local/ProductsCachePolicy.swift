//
//  ProductsCachePolicy.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 22/10/24.
//

import Foundation

final class ProductsCachePolicy {
    
    private init() {}
    
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static var maxCacheAgeInDays: Int { 1 }
    private static var maxCacheAgeInHours: Int { 6 }
    private static var maxCacheAgeInSeconds: Int { 15 }
    
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        
        guard let maxCacheAge = calendar.date(byAdding: .second, value: maxCacheAgeInSeconds, to: timestamp) else { return false }
        
        
        print("data", date)
        print("maxCacheAge", maxCacheAge)
        print("date < maxCacheAge", date < maxCacheAge)
        
        return date < maxCacheAge
    }
}
