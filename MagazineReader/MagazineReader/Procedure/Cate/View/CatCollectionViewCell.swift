//
//  CatCollectionViewCell.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/11.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UBaseCollectionViewCell {
    private lazy var titleLb: UILabel = {
        let lb = UILabel.init()
        lb.textAlignment = .center
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.text = "文学文摘"
        return lb
    }()
    
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
}
