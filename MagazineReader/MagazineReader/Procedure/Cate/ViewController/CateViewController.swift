//
//  CateViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/10.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate class collectionModel {
    var headerModel: categoryModel?
    var bodyModel: [magazinDescrModel]?
}

class CateViewController: UBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var models = [collectionModel]()

    private lazy var collectionView: UICollectionView = {
        let cl = UICollectionViewFlowLayout.init()
        cl.sectionHeadersPinToVisibleBounds = true
        cl.minimumLineSpacing = 5
        cl.minimumInteritemSpacing = 5
        cl.itemSize = CGSize.init(width: screenWidth / 3 - 10, height: 120*sizeScale)
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: cl)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellType: CatCollectionViewCell.self)
        cv.register(supplementaryViewType: CatCollectionViewSectionHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        cv.register(supplementaryViewType: CatCollectionViewSectionFooter.self, ofKind: UICollectionView.elementKindSectionFooter)
        cv.mj_header = MJRefreshNormalHeader.init()
        cv.mj_header.setRefreshingTarget(self, refreshingAction: #selector(loadData))
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    @objc private func loadData() {
        if self.models.isEmpty == false {
            self.models.removeAll()
        }
        
        ApiLoadingProvider.request(.getAllCategory, model: [categoryModel].self) {  (categoryModels) in
            let group = DispatchGroup()
            categoryModels?.forEach({ (categoryModel) in
                guard let code = categoryModel.CategoryCode else {
                    return
                }
                group.enter()
                let model = collectionModel()
                model.headerModel = categoryModel
                self.models.append(model)
                ApiProvider.request(.getMagazineByCategory(categorycode: code), model: [magazinDescrModel].self) { [modelcopy = model] (magazinDescrModel) in
                    if let m = magazinDescrModel {
                        model.bodyModel = m
                    }
                    group.leave()
                }
            })
            
            group.notify(queue: DispatchQueue.main) {
                if self.collectionView.mj_header.state == .refreshing {
                    self.collectionView.mj_header.endRefreshing()
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension CateViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = models[section].bodyModel?.count
        return count!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CatCollectionViewCell.self)
        cell.model = models[indexPath.section].bodyModel![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reuseView: UICollectionReusableView?
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: CatCollectionViewSectionHeader.self)
            reuseView = header
            let m = models[indexPath.section].headerModel
            header.model = m
            header.moreActionCLosure = { [weak self] in
                let detailVC = CatDetailViewController.init()
                detailVC.categorycode = m?.CategoryCode
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
            return reuseView!
        }
        
        reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: CatCollectionViewSectionFooter.self)
        return reuseView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: screenWidth, height: 45*sizeScale)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        vc.model = models[indexPath.section].bodyModel![indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
