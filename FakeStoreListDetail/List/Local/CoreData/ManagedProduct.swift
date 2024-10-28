//
//  ManagedProduct.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 23/10/24.
//

import CoreData

@objc(ManagedProduct)
class ManagedProduct: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
//    @NSManaged var desc: String?
    @NSManaged var price: NSNumber?
//    @NSManaged var category: String?
//    @NSManaged var rate: NSNumber?
//    @NSManaged var rateCount: NSNumber?
//    @NSManaged var url: URL?
    @NSManaged var cache: ManagedProductCache
}

extension ManagedProduct {
    
    static func product(from localProduct: [LocalProductItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        
        
//        let p = [localProduct[0], localProduct[1]]
//        
        let managedProducts: [ManagedProduct] = localProduct.map { (local: LocalProductItem) in
            
            let managed = ManagedProduct(context: context)
            managed.id = local.id
            managed.name = local.title
            managed.price = local.price as? NSNumber
//            managed.desc = local.description
//            managed.category = local.category
//            managed.url = local.imageURL
//            managed.rate = local.rating?.rate as? NSNumber
//            managed.rateCount = local.rating?.count  as? NSNumber
            
            return managed
        }
        
        return NSOrderedSet(array: managedProducts)
    }
    
    var local: LocalProductItem {
        LocalProductItem(
            id: id,
            title: name,
            price: price as? Double,
            description: nil,//desc,
            category: nil,//category,
            imageURL: nil,//url,
            rating: nil)//LocalRatingItem(rate: rate as? Double, count: rateCount as? Int))
    }
}

