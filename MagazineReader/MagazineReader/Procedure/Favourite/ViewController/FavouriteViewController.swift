//
//  FavouriteViewController.swift
//  MagazineReader
//
//  Created by 李前途 on 2019/10/13.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import WebKit
import MJRefresh

class FavouriteViewController: UBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var models: [favouriteMagzineModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.itemSize = CGSize.init(width: screenWidth / 2 - 10, height: 240*sizeScale)
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellType: FavouriteCollectionViewCell.self)
        cv.mj_header = MJRefreshNormalHeader { [weak self] in
            self?.loadData()
        }
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        self.collectionView.mj_header.beginRefreshing()
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.usnp.edges)
        }
    }
    
    func loadData() {
        models.removeAll()
        models = FMDBToolSingleton.sharedInstance.getFavouriteList()
        collectionView.reloadData()
        collectionView.mj_header.endRefreshing()
    }
}

extension FavouriteViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FavouriteCollectionViewCell.self)
        cell.model = models[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        let temp = models[indexPath.row]
        let m = magazinDescrModel.init(MagazineGuid: temp.magazineguid, MagazineName: temp.MagazineName, Year: temp.Year, Issue: temp.Issue, CoverImages: [temp.CoverImage,temp.CoverImage,temp.CoverImage,temp.CoverImage])
        vc.model = m
        navigationController?.pushViewController(vc, animated: true)
    }
}


