
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
        lb.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        return lb
    }()
    
    override func configUI() {
        addSubview(coverView)
        addSubview(releaseDateLb)
        
        coverView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 5, bottom: 25, right: 5))
        }
        
        releaseDateLb.snp.makeConstraints { (make) in
            make.left.equalTo(coverView.snp.left)
            make.top.equalTo(coverView.snp.bottom).offset(5*sizeScale)
        }
    }
    
    var model: favouriteMagzineModel? {
        didSet {
            coverView.kf.setImage(with: URL.init(string: model!.CoverImage))
            releaseDateLb.text = "更新至\(model!.Year)年\(model!.Issue)期"

        }
    }
}
