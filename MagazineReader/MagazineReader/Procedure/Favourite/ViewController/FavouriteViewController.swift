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
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.itemSize = CGSize.init(width: screenWidth / 2 - 8, height: 240*sizeScale)
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
        let longPress = UILongPressGestureRecognizer()
        longPress.addTarget(self, action: #selector(removeAct(sender:)))
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        let temp = models[indexPath.row]
        let m = magazinDescrModel.init(MagazineGuid: temp.magazineguid, MagazineName: temp.MagazineName, Year: temp.Year, Issue: temp.Issue, CoverImages: [temp.CoverImage,temp.CoverImage,temp.CoverImage,temp.CoverImage])
        vc.model = m
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func removeAct(sender: Any) {
        let gr = sender as! UILongPressGestureRecognizer
        let cell = gr.view! as! FavouriteCollectionViewCell
        let magazinID = cell.model!.magazineguid
        
        let aVC = UIAlertController.init(title: "是否移除", message: "", preferredStyle: UIAlertController.Style.alert)
        let act = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (act) in
            let indexPath = self.collectionView.indexPath(for: cell)
            FMDBToolSingleton.sharedInstance.removeFavouriteMagzine(magazineguid: magazinID) { (res) in
                if res {
                    self.collectionView.deleteItems(at: [indexPath!])
                    self.models = FMDBToolSingleton.sharedInstance.getFavouriteList()
                    self.collectionView.reloadData(animation: true)
                }
            }
            
        }
        let cancelAct = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (act) in
            
        }
        aVC.addAction(act)
        aVC.addAction(cancelAct)
        self.present(aVC, animated: true, completion: nil)
        
    }
}


