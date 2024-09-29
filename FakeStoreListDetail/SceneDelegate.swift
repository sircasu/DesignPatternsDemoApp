//
//  SceneDelegate.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 17/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var navigationController = UINavigationController(
        rootViewController: ListUIComposer.createListViewController(
            onButtonPressed: onButtonPressed
        ))
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        //
        
        
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }
    
    
    private func onButtonPressed(intParam: Int) {
        let detailController = DetailUIComposer.createDetailViewController(with: intParam)
        
        navigationController.pushViewController(detailController, animated: true)
    }
}


final class ListUIComposer {
    
    private init() {}
    
    static func createListViewController(onButtonPressed: ((Int) -> Void)?) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        
        let remoteLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: URLSessionHTTPClient(session: URLSession(configuration: URLSessionConfiguration.ephemeral))))
        
        let AFRemoteLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: AFHTTPClient()))
        
        let AFRemoteLoaderWithSingletonClient = MainQueueDispatchProductsLoaderDecorator(decoratee: RemoteProductsLoader(httpClient: AFHTTPClientSingleton.shared))
        
        let mockLoader = MainQueueDispatchProductsLoaderDecorator(decoratee: MockProductsLoader())
        let listController = storyboard.instantiateInitialViewController(creator: { coder in
            
            return ListViewController(coder: coder, onButtonTapped: onButtonPressed, listLoader: AFRemoteLoaderWithSingletonClient)
        })
        
        return listController!
    }
}

final class DetailUIComposer {
    
    private init() {}
    
    static func createDetailViewController(with param: Int) -> DetailViewController {
        
        let bundle = Bundle(for: DetailViewController.self)
        let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
        
        let detailController = storyboard.instantiateInitialViewController(creator: { coder in
            
            return DetailViewController(coder: coder, intParam: param)
        })
        
        return detailController!
    }
}


final class MainQueueDispatchProductsLoaderDecorator: ProductsLoader {
    
    let decoratee: ProductsLoader
    
    init(decoratee: ProductsLoader) {
        self.decoratee = decoratee
    }
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        decoratee.loadProducts { res in

            guard Thread.isMainThread else {
                return DispatchQueue.main.async {
                    completion(res)
                }
            }
            
            completion(res)

        }
    }
}

final class MainQueueDispatchDecorator<T> {

    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {

        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}


extension MainQueueDispatchDecorator: ProductsLoader where T == ProductsLoader {
   
    
    func loadProducts(completion: @escaping (ProductsLoader.Result) -> Void?) {
        
        decoratee.loadProducts { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
