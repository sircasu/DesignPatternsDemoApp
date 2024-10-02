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




