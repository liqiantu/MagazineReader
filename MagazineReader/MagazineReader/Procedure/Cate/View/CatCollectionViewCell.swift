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
