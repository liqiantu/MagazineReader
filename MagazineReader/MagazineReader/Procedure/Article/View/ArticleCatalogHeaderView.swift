//
//  ArticleCatalogHeaderView.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogHeaderView: UIView {
    var viewFrame: CGRect!

    private lazy var backView: UIView = {
        let v = UIView.init()
        return v
    }()
    
    private lazy var backImageView: UIImageView = {
       let v = UIImageView()
        return v
    }()
    
    private lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect.init(style: UIBlurEffect.Style.light)
        let effectV = UIVisualEffectView.init(effect: effect)
        return effectV
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
        configUI()
    }

    func configUI() {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backImageView.addSubview(effectView)
        effectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backImageView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 80, height: 150))
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        viewFrame = bounds
    }

    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = viewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        backView.frame = frame
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: articleModel? {
        didSet {
            
        }
    }
}
