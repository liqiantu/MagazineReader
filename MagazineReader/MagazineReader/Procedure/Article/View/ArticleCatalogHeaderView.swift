//
//  ArticleCatalogHeaderView.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogHeaderView: UIView {
    var bgFrame: CGRect!

    private lazy var bgView: UIImageView = {
        let bw = UIImageView()
        bw.isUserInteractionEnabled = true
        bw.contentMode = .scaleAspectFill
        
        let url = URL.init(string: "http://img1.qikan.com/qkimages/duzh/duzh201921-l.jpg")
        bw.kf.setImage(with: url)
        
        bw.blurView.setup(style: .dark, alpha: 1).enable()
        return bw
    }()

    private lazy var coverView: UIImageView = {
        let cw = UIImageView()
        cw.contentMode = .scaleAspectFill
        cw.layer.cornerRadius = 3
        cw.layer.borderWidth = 1
        cw.layer.borderColor = UIColor.white.cgColor
        return cw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configUI()
        
        backgroundColor = UIColor.red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgFrame = bgView.frame
    }
    
    func configUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = bgFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        bgView.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
