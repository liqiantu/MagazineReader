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

class ArticleDetailViewController: UBaseViewController {
    public var model: magazinDescrModel?
    public var isLastIssue = false
    
    private lazy var categoryView: JXCategoryTitleView = {
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
    
    lazy var pagingView: JXPagingListRefreshView = {
        let v = JXPagingListRefreshView.init(delegate: self)
        v.mainTableView.gestureDelegate = self
        return v
    }()
    
    lazy var header: ArticleCatalogHeaderView = {
        let h = ArticleCatalogHeaderView.init(frame: CGRect.zero)
        h.model = self.model
        return h
    }()
    
    lazy var customNavBar: ArticleCustomNavBar = {
        let v = ArticleCustomNavBar()
        v.title = self.model?.MagazineName
        v.backAct = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        if isLastIssue {
            v.isShowLeft = true
            v.leftAct = {
                guard let m = self.model else { return }
                let myModel = favouriteMagzineModel.init(magazineguid: m.MagazineGuid!, MagazineName: m.MagazineName!, Year: m.Year, Issue: m.Issue, CoverImage: m.CoverImages![3])
                FMDBToolSingleton.sharedInstance.addFavouriteMagzine(model: myModel) { (res) in
                    
                }
            }
        }
        
        return v
    }()
    
    var titles = ["目录", "往期"] // 目录 详情 简介 cell 两种展示模式
    weak var nestContentScrollView: UIScrollView?    //嵌套demo使用
    //    var tableHeaderViewHeight: Int = Int(225*sizeScale)
    var tableHeaderViewHeight: Int = Int(350*sizeScale)
    var headerInSectionHeight: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.model?.MagazineName
        self.navigationController?.navigationBar.isTranslucent = false
        
        configUI()
        
        // 设置收藏按钮
//        if let islast = self.isLastIssue {
//            if islast {
////                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "添加收藏",  style: UIBarButtonItem.Style.plain, target: self, action: #selector(addFavourite))
//                //                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消收藏",  style: UIBarButtonItem.Style.plain, target: self, action: #selector(removeFavourite))
//            }
//        }
    }
    
    override func configUI() {
        view.addSubview(self.pagingView)
        categoryView.contentScrollView = pagingView.listContainerView.collectionView
        //扣边返回处理，下面的代码要加上
        pagingView.listContainerView.collectionView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        pagingView.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        
        let naviHeight = UIApplication.shared.keyWindow!.jx_navigationHeight()
        //导航栏隐藏就是设置pinSectionHeaderVerticalOffset属性即可，数值越大越往下沉
        pagingView.pinSectionHeaderVerticalOffset = Int(naviHeight)
        
        view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(naviHeight)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (categoryView.selectedIndex == 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    @objc func addFavourite() {
//    }
//    @objc func removeFavourite() {
//    }
}

extension ArticleDetailViewController: JXCategoryViewDelegate {
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didClickedItemContentScrollViewTransitionTo index: Int){
        //请务必实现该方法
        //因为底层触发列表加载是在代理方法：`- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`回调里面
        //所以，如果当前有5个item，当前在第1个，用于点击了第5个。categoryView默认是通过设置contentOffset.x滚动到指定的位置，这个时候有个问题，就会触发中间2、3、4的cellForItemAtIndexPath方法。
        //如此一来就丧失了延迟加载的功能
        //所以，如果你想规避这样的情况发生，那么务必按照这里的方法处理滚动。
        self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
        
        
        //如果你想相邻的两个item切换时，通过有动画滚动实现。未相邻的两个item直接切换，可以用下面这段代码
        /*
         let diffIndex = abs(categoryView.selectedIndex - index)
         if diffIndex > 1 {
         self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
         }else {
         self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
         }
         */
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        let thresholdDistance: CGFloat = 100
        var percent = scrollView.contentOffset.y/thresholdDistance
        percent = max(0, min(1, percent))
        customNavBar.alpha = percent
    }
}

extension ArticleDetailViewController: JXPagingViewDelegate {
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return tableHeaderViewHeight
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return header
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return headerInSectionHeight
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return categoryView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {        
        if index == 0 {
            let vc = ArticleCatalogViewController()
            vc.model = self.model
            vc.navVc = self.navigationController
            return vc
        }
        
        let vc = ArticlePastIssueViewController()
        vc.model = self.model
        vc.navVc = self.navigationController
        return vc
    }
}

extension ArticleDetailViewController: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止Nest嵌套效果的时候，上下和左右都可以滚动
        if otherGestureRecognizer.view == nestContentScrollView {
            return false
        }
        //禁止categoryView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == categoryView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder())
    }
}
