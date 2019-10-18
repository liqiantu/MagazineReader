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
        let cl = UICollectionViewFlowLayout.init()
        cl.minimumLineSpacing = 1
        cl.minimumInteritemSpacing = 1
        cl.itemSize = CGSize.init(width: screenWidth / 2 - 2, height: 88*sizeScale)
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: cl)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellType: CatCollectionViewCell.self)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {

    }
    
}

extension FavouriteViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CatCollectionViewCell.self)
        return cell
    }
}
