//
//  ArticleCatalogViewCellCollectionViewCell.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogViewCellCollectionViewCell: UBaseCollectionViewCell {
    private lazy var titleLb: UILabel = {
        let v = UILabel.init()
        v.textColor = .black
        return v
    }()
    
    private lazy var authorLb: UILabel = {
        let v = UILabel.init()
        v.font = UIFont.systemFont(ofSize: 12)
        v.textColor = UIColor.lightGray
        return v
    }()
    
    override func configUI() {
        backgroundColor = UIColor.white
        contentView.addSubview(titleLb)
        contentView.addSubview(authorLb)
        
        titleLb.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10*sizeScale)
            make.top.equalToSuperview().offset(5*sizeScale)
        }
        authorLb.snp.makeConstraints { (make) in
            make.top.equalTo(titleLb.snp.bottom).offset(5*sizeScale)
            make.left.equalTo(self.titleLb)
        }
    }
    
    var model: articleModel? {
        didSet {
            titleLb.text = model?.Title
            authorLb.text = model?.Author
        }
    }
}
