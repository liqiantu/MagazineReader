
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
        imgv.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        imgv.layer.shadowColor = UIColor.black.cgColor
        imgv.layer.shadowOpacity = 0.8
        imgv.layer.masksToBounds = false
        return imgv
    }()
    
    private lazy var releaseDateLb: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        return lb
    }()
    
    override func configUI() {
        // https://www.jianshu.com/p/590ea786c74f
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        addSubview(coverView)
        addSubview(releaseDateLb)
        
        coverView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 5, bottom: 25, right: 5))
        }
        
        releaseDateLb.snp.makeConstraints { (make) in
            make.left.equalTo(coverView.snp.left).offset(2)
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
