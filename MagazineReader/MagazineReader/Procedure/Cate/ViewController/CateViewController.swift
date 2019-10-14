//
//  CateViewController.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/10.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class CateViewController: UBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
        cv.register(supplementaryViewType: CatCollectionViewSectionHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadData()
    }
    
    override func configUI() {
        view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
    }
    
    private func loadData() {
        
        ApiProvider.request(.getAllCategory, model: [categoryModel].self) { (res) in
            print(res)
        }
        
    }

}

extension CateViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CatCollectionViewCell.self)
        return cell
    }
}
