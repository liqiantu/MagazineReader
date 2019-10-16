//
//  ArticleCatalogViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogViewController: UBaseViewController {

    private lazy var tableView: UITableView = {
           let tw = UITableView(frame: .zero, style: .plain)
           tw.backgroundColor = UIColor.background
           tw.delegate = self
           tw.dataSource = self
           tw.tableFooterView = UIView()
           tw.register(cellType: ArticleCatalogTableViewCell.self)
           return tw
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension ArticleCatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ArticleCatalogTableViewCell.self)
        
        return cell
    }
    
    
}
