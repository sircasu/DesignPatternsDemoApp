//
//  ViewController.swift
//  FakeStoreListDetail
//
//  Created by Matteo Casu on 17/09/24.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var onButtonTapped: ((Int) -> Void)?
    var listLoader: ProductsLoader?
    
    private var items: [ProductItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        self.loadProducts()
    }

    
    init?(coder: NSCoder, onButtonTapped: ((Int) -> Void)?, listLoader: ProductsLoader) {
        super.init(coder: coder)
        self.onButtonTapped = onButtonTapped
        self.listLoader = listLoader
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //
    func loadProducts() {
        listLoader?.loadProducts { [weak self] result in
            
            if case .success(let listItems) = result {
                self?.items = listItems
                self?.tableView.reloadData()
            }
        }
    }
}


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        
        let price = formatter.string(from: item.price! as NSNumber) ?? "0.00"
        cell.textLabel?.text = "\(item.title) - Price: \(price)"
        
        return cell
    }
}


extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        onButtonTapped?(item.id)
    }
}
