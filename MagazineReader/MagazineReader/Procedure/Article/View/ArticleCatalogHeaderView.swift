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
        cw.contentMode = .scaleAspectFit
        return cw
    }()
    
    private lazy var releaseDateLb: UILabel = {
        let lb = UILabel.init()
        lb.textColor = .white
        return lb
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
            make.top.equalToSuperview().offset(5*sizeScale)
            make.size.equalTo(CGSize.init(width: screenWidth, height: 300*sizeScale))
        }
        
        backImageView.addSubview(releaseDateLb)
        releaseDateLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(coverView.snp.bottom).offset(10*sizeScale)
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

    public var model: magazinDescrModel? {
        didSet {
            backImageView.kf.setImage(with: URL.init(string: (model?.CoverImages![2])!))
            coverView.kf.setImage(with: URL.init(string: (model?.CoverImages![3])!))
            releaseDateLb.text = "\(model!.Year)年\(model!.Issue)期"
        }
    }
}
