//
//  MineViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/10.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

    // How to create a Section Background in a UICollectionView in Swift
    //    http://strawberrycode.com/blog/how-to-create-a-section-background-in-a-uicollectionview-in-ios-swift/

class MineViewController: UBaseViewController {

    private var height: CGFloat = 300
    
    private lazy var mineArr: Array = [
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存",
        "清理缓存"

    ]
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.background
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: UBaseTableViewCell.self)
        return tw
    }()
    
    private lazy var headerView: MineHeader = {
        let v = MineHeader.init()
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
    }
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mineArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UBaseTableViewCell.self)
        cell.textLabel?.text = mineArr[indexPath.row]
        return cell
    }    
}
