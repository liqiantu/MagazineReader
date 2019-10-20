//
//  FavouriteViewController.swift
//  MagazineReader
//
//  Created by 李前途 on 2019/10/13.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import WebKit

class FavouriteViewController: UBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.itemSize = CGSize.init(width: screenWidth / 3 - 10, height: 220*sizeScale)
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellType: FavouriteCollectionViewCell.self)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.usnp.edges)
        }
    }
    
}

extension FavouriteViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FavouriteCollectionViewCell.self)
        return cell
    }
}

fileprivate struct favourModel {
    var ArticleID: String = ""
    var MagazineName: String = ""
    var Year: String = ""
    var Issue: String = ""
}
