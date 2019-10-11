//
//  Model.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/9.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation
import HandyJSON

// 杂志分类
struct category: HandyJSON {
    var CategoryCode: String?
    var CategoryName: String?
    var ResourceTotal: Int = 0
}
