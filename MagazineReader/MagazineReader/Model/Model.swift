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
    
    // 分页相关
    var PageIndex: Int = 0
    var PageSize: Int = 0
    var PageTotal: Int = 0
    var ItemCount: Int = 0
}

// 杂志分类
struct categoryModel: HandyJSON {
    var CategoryCode: String?
    var CategoryName: String?
    var ResourceTotal: Int = 0
}

// 杂志简介
struct magazinDescrModel: HandyJSON {
    var MagazineGuid: String?
    var MagazineName: String?
    var Year: String = ""
    var Issue: String = ""
    var CoverImages: [String]? // [2] large 图片
}

