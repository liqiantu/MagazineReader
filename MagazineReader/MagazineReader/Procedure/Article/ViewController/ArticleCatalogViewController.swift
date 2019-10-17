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
    var model: magazinDescrModel?
    var catalogModels = [magazinCatalogModel]()
    
    private lazy var collectionView: UICollectionView = {
        let cl = UICollectionViewFlowLayout.init()
        cl.minimumLineSpacing = 5
        cl.minimumInteritemSpacing = 5
        cl.itemSize = CGSize.init(width: screenWidth / 3 - 10, height: 120*sizeScale)
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
            self.catalogModels = res!
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
