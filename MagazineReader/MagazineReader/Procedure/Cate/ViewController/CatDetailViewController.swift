//
//  CatDetailViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/15.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import MJRefresh

class CatDetailViewController: UBaseViewController {
    public var categorycode: String?

    private var modelArr: [magazinDescrModel] = []
    
    private let pageSize: Int = PageInfo.size.rawValue
    private var pageIndex: Int = PageInfo.index.rawValue
    private var pageTotal: Int?
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.background
        tw.delegate = self
        tw.dataSource = self
        tw.tableFooterView = UIView()
        tw.register(cellType: CatDetailCell.self)
        tw.mj_header = MJRefreshNormalHeader { self.loadData(more: false) }
        tw.mj_footer = MJRefreshAutoNormalFooter { self.loadData(more: true) }
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_header.beginRefreshing()
    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.usnp.edges)
        }
    }
    
    @objc private func loadData(more: Bool) {
        guard let cCode = categorycode else {
            return
        }
        
        pageIndex = more ? pageIndex+1 : 1
        
        if let total = self.pageTotal {
            if self.pageIndex > total {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }else {
                self.tableView.mj_footer.resetNoMoreData()
            }
        }
                
        ApiLoadingProvider.requestPageInfo(.getMagazineByCategoryWithPage(categorycode: cCode, pagesize: pageSize, pageindex: pageIndex), model: [magazinDescrModel].self) { (result) in
            guard let model = result else { return }
            self.pageTotal = model.PageTotal
            if more {
                self.tableView.mj_footer.endRefreshing()
                self.modelArr += model.Data!
            }else {
                self.tableView.mj_header.endRefreshing()
                self.modelArr.removeAll()
                self.modelArr = model.Data!
            }
            self.tableView.reloadData()
        }
    }

}

extension CatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CatDetailCell.self)
        cell.model = modelArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130*sizeScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        vc.model = self.modelArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
