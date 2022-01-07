//
//  ProductTableViewController.swift
//  SeSAC_Danggn
//
//  Created by 김지현 on 2021/12/17.
//

import UIKit
import SnapKit

class ProductTableViewController: UIViewController {
    
    let productTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        view.backgroundColor = .white
        setConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setConstraint() {
        self.view.addSubview(productTableView)
        
        productTableView.snp.makeConstraints {
            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.topMargin.equalTo(view)
            $0.bottomMargin.equalTo(view)
        }
    }
    
}

extension ProductTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
