//
//  ListUIComposer.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//
import UIKit

final class ListUIComposer {
    
    private init() {}
    
    static func createListViewController(productsLoader: ProductsLoader, onButtonPressed: ((Int) -> Void)?) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        

        let listController = storyboard.instantiateInitialViewController(creator: { coder in
            
            return ListViewController(
                coder: coder,
                onButtonTapped: onButtonPressed,
                listLoader: MainQueueDispatchProductsLoaderDecorator(decoratee: productsLoader))
        })
        
        return listController!
    }
}
