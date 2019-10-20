
//
//  FavouriteCollectionViewCell.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/20.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UBaseCollectionViewCell {
    private lazy var coverView: UIImageView = {
        let imgv = UIImageView.init()
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    private lazy var releaseDateLb: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 13)
        return lb
    }()
    
    private lazy var magazinNameLb: UILabel = {
       let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
       return lb
    }()
    
    override func configUI() {
        addSubview(coverView)
        addSubview(releaseDateLb)
        addSubview(magazinNameLb)
        
        contentView.backgroundColor = .red
        
        coverView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5*sizeScale)
            make.size.equalTo(CGSize.init(width: 77*sizeScale, height: 101*sizeScale))
        }
        
        releaseDateLb.snp.makeConstraints { (make) in
            make.left.equalTo(coverView.snp.left)
            make.top.equalTo(coverView.snp.bottom).offset(5*sizeScale)
        }
        
        magazinNameLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(releaseDateLb.snp.bottom).offset(3*sizeScale)

        }
    }
}
