//
//  CatDetailCell.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class CatDetailCell: UBaseTableViewCell {

    private lazy var coveImgV: UIImageView = {
        let imgv = UIImageView.init()
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    private lazy var titleLb: UILabel = {
        let lb = UILabel.init()
        return lb
    }()
    
    private lazy var updateDateLb: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 13*sizeScale)
        lb.textColor = .lightGray
        return lb
    }()
    
    override func configUI() {
        contentView.addSubview(coveImgV)
        contentView.addSubview(titleLb)
        contentView.addSubview(updateDateLb)
        
        coveImgV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 90*sizeScale, height: 125*sizeScale))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10*sizeScale)
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.top.equalTo(coveImgV.snp.top).offset(10*sizeScale)
            make.left.equalTo(coveImgV.snp.right).offset(10*sizeScale)
            make.right.equalToSuperview()
        }
        
        updateDateLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb)
            make.top.equalTo(titleLb.snp.bottom).offset(10*sizeScale)
        }
    }
    
    var model: magazinDescrModel? {
        didSet {
            coveImgV.kf.setImage(with: URL.init(string: (model?.CoverImages![2])!))
            titleLb.text = model?.MagazineName
            updateDateLb.text = "更新至\(model!.Year)年\(model!.Issue)期"
        }
    }

}
