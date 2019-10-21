//
//  ArticleCustomNavBar.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/21.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

typealias backClosures = () -> Void

class ArticleCustomNavBar: UIView {
    var backAct: backClosures?
    var title: String? {
        didSet {
            naviTitleLabel.text = title
        }
    }
    
    public lazy var naviTitleLabel: UILabel = {
        let lb = UILabel.init()
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.setTitle("返回", for: .normal)
        back.addTarget(self, action: #selector(naviBack), for: .touchUpInside)
        return back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    
    func config() {
        backgroundColor = .white
        alpha = 0
        
        let topSafeMargin = UIApplication.shared.keyWindow!.jx_layoutInsets().top
        
        addSubview(naviTitleLabel)
        addSubview(backButton)
        
        naviTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(topSafeMargin)
            make.height.equalTo(44)
        }
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(topSafeMargin)
            make.size.equalTo(CGSize.init(width: 44,height: 44))
        }
    }
    
    @objc func naviBack() {
        guard let act =  backAct else {
            return
        }
        act()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
