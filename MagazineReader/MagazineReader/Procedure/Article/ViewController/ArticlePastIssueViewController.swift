//
//  ArticlePastIssueViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import MJRefresh
import JXPagingView

class ArticlePastIssueViewController: UBaseViewController {
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.background
        tw.delegate = self
        tw.dataSource = self
        tw.tableFooterView = UIView()
        tw.register(cellType: CatDetailCell.self)
        tw.mj_header = MJRefreshNormalHeader { self.loadData() }
        return tw
    }()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?

    var model: magazinDescrModel?
    private var modelArr: [magazinDescrModel] = []

    //如果使用UIViewController来封装逻辑，且要支持横竖屏切换，一定要加上下面这个方法。不加会有bug的。
    override func loadView() {
        self.view = UIView()
    }

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
    
    func loadData() {
        guard let m = self.model else { return }
        ApiProvider.request(.getMagazineIssues(magazineguid: m.MagazineGuid!), model: [magazinDescrModel].self) { (res) in
            guard let models = res else { return }
            self.modelArr = models
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

extension ArticlePastIssueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CatDetailCell.self)
        cell.model = self.modelArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140*sizeScale
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}

extension ArticlePastIssueViewController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return self.view
    }

    func listScrollView() -> UIScrollView {
        return tableView
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallback = callback
    }
}
