//
//  ListUIComposer.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import UIKit

final class ListUIComposer {
    
    private init() {}
    
    static func createListViewController(onButtonPressed: ((Int) -> Void)?) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        
        let remoteLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: URLSessionHTTPClient(session: URLSession(configuration: URLSessionConfiguration.ephemeral))))
        
        let AFRemoteLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: AFHTTPClient()))
        
        let AFRemoteLoaderWithSingletonClient = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: AFHTTPClientSingleton.shared))
        
        let mockLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: MockProductsLoader())
        
        // local
        let localLoader = LocalProductLoader(productStore: UserDefaultsProductStore())
        //
        
        let listController = storyboard.instantiateInitialViewController(creator: { coder in
            
            return ListViewController(coder: coder, onButtonTapped: onButtonPressed, listLoader: AFRemoteLoaderWithSingletonClient, localProductLoader: localLoader)
        })
        
        return listController!
    }
}
