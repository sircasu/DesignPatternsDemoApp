//
//  ManagedProductCache.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 23/10/24.
//

import CoreData

@objc(ManagedProductCache)
class ManagedProductCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var product: NSOrderedSet
}


extension ManagedProductCache {
    
    static func find(in context: NSManagedObjectContext) throws -> ManagedProductCache? {
        
        let request = NSFetchRequest<ManagedProductCache>(entityName: ManagedProductCache.entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws ->  ManagedProductCache {
        
        try find(in: context).map(context.delete)
        return ManagedProductCache(context: context)
    }
    
    var localProduct: [LocalProductItem] {
        return product.compactMap { ($0 as? ManagedProduct)?.local }
    }
}
