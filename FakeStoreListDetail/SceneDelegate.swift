//
//  SceneDelegate.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 17/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // remote loaders
    private lazy var URLSessionRemoteLoader =  RemoteProductsLoader(httpClient: URLSessionHTTPClient(session: URLSession(configuration: URLSessionConfiguration.ephemeral)))
    
    private lazy var AFRemoteLoader = RemoteProductsLoader(httpClient: AFHTTPClient())

    private lazy var AFRemoteLoaderWithSingletonClient = RemoteProductsLoader(httpClient: AFHTTPClientSingleton.shared)
    //
    // mock loader
    private lazy var mockLoader = MockProductsLoader()
    //
    // local loader
    let localLoader = LocalProductLoader(productStore: UserDefaultsProductStore(), currentDate: Date.init)
    //

    
    private lazy var navigationController = UINavigationController(
        rootViewController: ListUIComposer.createListViewController(
            productsLoader: ProductsLoaderStrategy(
                primary: localLoader,
                
                fallback: RemoteProductLoaderDecorator(decoratee: AFRemoteLoaderWithSingletonClient, cache: localLoader)
            ),
                
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
