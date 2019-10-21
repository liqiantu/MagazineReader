//
//  ArticleCatalogViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import MJRefresh
import JXPagingView

class ArticleCatalogViewController: UBaseViewController {
    var navVc: UINavigationController?
    var model: magazinDescrModel?
    var catalogModels = [magazinCatalogModel]()
    
    private lazy var collectionView: UICollectionView = {
        let cl = UICollectionViewFlowLayout.init()
        cl.minimumLineSpacing = 5
        cl.minimumInteritemSpacing = 5
        cl.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: cl)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellType: ArticleCatalogViewCellCollectionViewCell.self)
        cv.register(supplementaryViewType: ArticleCatalogCollectionReusableHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        cv.register(supplementaryViewType: ArticleCatalogCollectionReusableFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        cv.mj_header = MJRefreshNormalHeader { self.loadData() }
        return cv
    }()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    //如果使用UIViewController来封装逻辑，且要支持横竖屏切换，一定要加上下面这个方法。不加会有bug的。
    override func loadView() {
       self.view = UIView()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.mj_header.beginRefreshing()
    }
    
    override func configUI() {
        view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
    }
    
    func loadData() {
        guard let m = self.model else {
            return
        }
        ApiProvider.request(.getMagazineCatalog(magazineguid: m.MagazineGuid!, year: m.Year, issue: m.Issue), model: [magazinCatalogModel].self) { (res) in
            guard let r = res else { return }
            self.catalogModels = r
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

extension ArticleCatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogModels[section].Articles!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return catalogModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ArticleCatalogViewCellCollectionViewCell.self)
        cell.model = catalogModels[indexPath.section].Articles![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var h: CGFloat = 0
        let model = catalogModels[indexPath.section].Articles![indexPath.row]
        if model.Author.isEmpty {
            h = 45*sizeScale
        }else {
            h = 55*sizeScale
        }
        return CGSize.init(width: screenWidth, height: h)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let h = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: ArticleCatalogCollectionReusableHeaderView.self)
            h.model = self.catalogModels[indexPath.section]
            return h
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: ArticleCatalogCollectionReusableFooterView.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: screenWidth, height: 40*sizeScale)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cellW = screenWidth
        let cellH: CGFloat = 100
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: cellW, height: cellH)
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = maskLayer.frame
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = UIColor.green.cgColor
        
        let bezierPath = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: cellW, height: cellH), cornerRadius: 5)
        maskLayer.path = bezierPath.cgPath
        borderLayer.path = bezierPath.cgPath
        
//        cell.contentView.layer.insertSublayer(borderLayer, at: 0)
        cell.layer.mask = maskLayer
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleContentViewController()
        vc.model = catalogModels[indexPath.section].Articles![indexPath.row]
        navVc?.pushViewController(vc, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}

extension ArticleCatalogViewController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return self.view
    }

    func listScrollView() -> UIScrollView {
        return collectionView
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallback = callback
    }
}
