//
//  CatCollectionViewCell.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/11.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UBaseCollectionViewCell {
    
    private lazy var coverImgV: UIImageView = {
        let imgv = UIImageView.init()
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    override func configUI() {
        let url = URL.init(string: "http://img1.qikan.com/qkimages/duzh/duzh201921-l.jpg")
        coverImgV.kf.setImage(with: url)
        
        contentView.addSubview(coverImgV)
        coverImgV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    var model: magazinDescrModel? {
        didSet {
            guard let m = model else {
                return
            }
            
            coverImgV.kf.setImage(with: URL.init(string: m.CoverImages![2]))
        }
    }
}
