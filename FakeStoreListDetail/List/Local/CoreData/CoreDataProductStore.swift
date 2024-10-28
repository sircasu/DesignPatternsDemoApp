//
//  CoreDataProductStore.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 28/10/24.
//

import Foundation
import CoreData

public final class CoreDataProductStore {
    
    private static let modelName = "Store" // product store
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataProductStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    init(storeURL: URL) throws {
        
        guard let model = CoreDataProductStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataProductStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
            
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }

    deinit {
        cleanUpReferencesToPersistentStores()
    }
}


extension CoreDataProductStore: ProductStore {
    
    func deleteAll(completion: @escaping DeletionCompletion) {
        perform { context in
            
            completion(Result {
                
                try ManagedProductCache.find(in: context).map(context.delete).map(context.save)
                
            })
        }
    }
    
    func insert(_ products: [LocalProductItem], timestamp: Date, completion: @escaping (InsertionCompletion)) {
        
        perform { context in
            
            completion(Result {
                
                let managedProductCache = try ManagedProductCache.newUniqueInstance(in: context)
                
                managedProductCache.timestamp = timestamp
                managedProductCache.product = ManagedProduct.product(from: products, in: context)
                
                try context.save()
            })
            
        }
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        
        perform { context in
            
            completion(Result(catching:  {
                try ManagedProductCache.find(in: context).map {
                    return CachedProducts(products: $0.localProduct, timestamp: $0.timestamp)
                }
            }))
        }
    }
}
    

