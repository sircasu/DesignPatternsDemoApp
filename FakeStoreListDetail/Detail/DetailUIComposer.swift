//
//  DetailUIComposer.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 29/09/24.
//

import Foundation
import UIKit

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
