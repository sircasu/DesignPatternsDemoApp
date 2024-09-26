//
//  DetailViewController.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 17/09/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var paramLabel: UILabel!
    private var paramValue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    init?(coder: NSCoder, intParam: Int) {
        super.init(coder: coder)
        self.paramValue = intParam
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func setupViews() {
        paramLabel?.text = "Param: \(String(describing: self.paramValue ?? 0))"
    }
}
