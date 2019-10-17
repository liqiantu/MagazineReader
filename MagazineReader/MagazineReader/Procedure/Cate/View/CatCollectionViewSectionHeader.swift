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
    
    public var moreActionCLosure: catCollectionViewSectionHeaderMoreActionClosure?
    
    private lazy var titleLb: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = "文学文摘"
        return lb
    }()
    
    private lazy var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("更多", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(moreAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var bottemLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()

    override func configUI() {
        backgroundColor = .white
        
        addSubview(titleLb)
        addSubview(moreBtn)
        addSubview(bottemLine)
        
        titleLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15*sizeScale)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-15*sizeScale)
        }
        
        bottemLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1.5*sizeScale)
            make.top.equalTo(moreBtn.snp.bottom).offset(2*sizeScale)
        }
    }
    
    @objc func moreAction() {
        guard let closure = moreActionCLosure else {
            return
        }
        
        closure()
    }
    
    
    var model: categoryModel? {
        didSet {
            guard let m = model else { return }
            titleLb.text = m.CategoryName
        }
    }

}
