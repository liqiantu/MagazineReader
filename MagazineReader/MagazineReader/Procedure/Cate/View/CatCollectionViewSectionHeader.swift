//
//  CatHeaderVIew.swift
//  MagazineReader
//
//  Created by 李前途 on 2019/10/13.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

typealias catCollectionViewSectionHeaderMoreActionClosure = () -> Void

class CatCollectionViewSectionHeader: UBaseCollectionReusableView {
    
    private var moreActionCLosure: catCollectionViewSectionHeaderMoreActionClosure?
    
    private lazy var titleLb: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = "文学文摘"
        return lb
    }()
    
    private lazy var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("更多", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(moreAction), for: UIControl.Event.touchUpInside)
        return btn
    }()

    override func configUI() {
        addSubview(titleLb)
        addSubview(moreBtn)
        
        titleLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15*sizeScale)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15*sizeScale)
        }
    }
    
    @objc func moreAction() {
        print("clickMore")
        
        guard let closure = moreActionCLosure else {
            return
        }
        
        closure()
    }

}
