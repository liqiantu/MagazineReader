//
//  ArticleCatalogCollectionReusableHeaderView.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogCollectionReusableHeaderView: UBaseCollectionReusableView {
    private lazy var titleLb: UILabel = {
        let v = UILabel()
        v.textColor = .purple
        return v
    }()
    
    override func configUI() {
        addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    var model: magazinCatalogModel? {
        didSet {
            titleLb.text = model?.Column
        }
    }
}
