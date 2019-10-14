//
//  Model.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/9.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation
import HandyJSON

struct ResponseData<T>: HandyJSON {
    var Code: Int = 0
    var Data: T?
    var Message: String = ""
}

// 杂志分类
struct categoryModel: HandyJSON {
    var CategoryCode: String?
    var CategoryName: String?
    var ResourceTotal: Int = 0
}
