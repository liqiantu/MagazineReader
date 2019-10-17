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
    
    var _models: [magazinDescrModel]?
    
}

// 杂志简介
struct magazinDescrModel: HandyJSON {
    var MagazineGuid: String?
    var MagazineName: String?
    var Year: String = ""
    var Issue: String = ""
    var CoverImages: [String]? // [2] large 图片
}

// 当期杂志简介
struct magazineIssueModel: HandyJSON {
    var MagazineGuid: String?
    var MagazineName: String = ""
    var Year: String = ""
    var Issue: String = ""
    var Note: String = ""
    var CoverImages: [String]? // [2] large 图片
}

// 杂志目录
struct magazinCatalogModel: HandyJSON {
    var Column: String = ""
    var Articles: [articleModel]?
}

// 目录中每个文章的简介
struct articleModel: HandyJSON {
    var ArticleID: String?
    var Title: String = ""
    var Author: String = ""
    var Summary: String = ""
    var FirstImg: String?
    var IsCover: Bool = false
    var Sequence: Int = 1
}

// 文章内容

struct PreviousNextArticle {
    var ArticleID: String = ""
    var Title: String = ""
}

struct articleContentModel: HandyJSON {
    var ArticleID: String = ""
    var Title: String = ""
    var SubTitle: String = ""
    var Author: String = ""
    var Summary: String = ""
    var Content: String = ""
    var PreviousArticle: PreviousNextArticle?
    var NextArticle: PreviousNextArticle?
    var PageCount: Int = 0
}
