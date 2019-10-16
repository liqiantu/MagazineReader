//
//  ArticleCatalogViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import JXPagingView
import JXCategoryView

class ArticleCatalogViewController: UBaseViewController {
    
    lazy var categoryView: JXCategoryTitleView = {
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat(headerInSectionHeight)))
        categoryView.titles = titles
        categoryView.backgroundColor = UIColor.white
        categoryView.titleSelectedColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        categoryView.titleColor = UIColor.black
        categoryView.isTitleColorGradientEnabled = true
        categoryView.isTitleLabelZoomEnabled = true
        categoryView.delegate = self
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.indicatorColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        lineView.indicatorWidth = 30
        categoryView.indicators = [lineView]
        
        let lineWidth = 1/UIScreen.main.scale
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.lightGray
        bottomLineView.frame = CGRect(x: 0, y: categoryView.bounds.height - lineWidth, width: categoryView.bounds.width, height: lineWidth)
        bottomLineView.autoresizingMask = .flexibleWidth
        categoryView.addSubview(bottomLineView)
        
        return categoryView
    }()
    
    lazy var pagingView: JXPagingView = {
        let v = JXPagingView.init(delegate: self)
        v.mainTableView.gestureDelegate = self
        return v
    }()
    
    lazy var userHeaderView: ArticleCatalogHeaderView = {
        let h = ArticleCatalogHeaderView.init(frame: CGRect.zero)
        return h
    }()
    
    var titles = ["目录", "往期"] // 目录 详情 简介 cell 两种展示模式
    weak var nestContentScrollView: UIScrollView?    //嵌套demo使用
    var tableHeaderViewHeight: Int = 200
    var headerInSectionHeight: Int = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        view.addSubview(self.pagingView)
        categoryView.contentScrollView = pagingView.listContainerView.collectionView

        //扣边返回处理，下面的代码要加上
        pagingView.listContainerView.collectionView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        pagingView.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (categoryView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.frame = self.view.bounds
    }
}

extension ArticleCatalogViewController: JXCategoryViewDelegate {
    
}

extension ArticleCatalogViewController: JXPagingViewDelegate {
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        <#code#>
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        <#code#>
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        <#code#>
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        <#code#>
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        
    }
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return title!.count
    }
}

extension ArticleCatalogViewController: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        <#code#>
    }
    
    
}
