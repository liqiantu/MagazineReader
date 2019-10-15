//
//  MineViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/10.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

    // AutoLayout实现Parallax Header
    //https://www.jianshu.com/p/714507b0129c
    // How to create a Section Background in a UICollectionView in Swift
    //    http://strawberrycode.com/blog/how-to-create-a-section-background-in-a-uicollectionview-in-ios-swift/

class MineViewController: UBaseViewController {

    private lazy var mineArr: Array = [
        "清理缓存"
    ]
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.background
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: UBaseTableViewCell.self)
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mineArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UBaseTableViewCell.self)
        return cell
    }
    
    
}
