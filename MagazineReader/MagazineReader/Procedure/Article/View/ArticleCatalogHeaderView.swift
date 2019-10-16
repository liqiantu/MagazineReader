//
//  ArticleCatalogHeaderView.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/16.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleCatalogHeaderView: UIView {
    private lazy var bgView: UIImageView = {
        let bw = UIImageView()
        bw.isUserInteractionEnabled = true
        bw.contentMode = .scaleAspectFill
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
}
