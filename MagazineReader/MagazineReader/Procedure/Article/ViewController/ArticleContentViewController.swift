//
//  ArticleContentViewController.swift
//  MagazineReader
//
//  Created by 李前途 on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit

class ArticleContentViewController: UBaseViewController {
    
    var model: articleModel?
    var models: [articleContentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func configUI() {
        
    }
    
    func loadData() {
        // https://www.jianshu.com/p/09d1ebcbd2a0 ios串行请求方案
        ApiProvider.request(.getDetail(articleid: model!.ArticleID!), model: articleContentModel.self) { (res) in
            self.models.append(res!)
            print("count is \(res!.PageCount)")
            let count = res!.PageCount - 1
            var articleidArr = [String]()
            if count > 0 {
                for index in 1...count {
                    let str = "\(self.model!.ArticleID!)-\(String(index))"
                    articleidArr.append(str)
                }
                
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    let group = DispatchGroup()
                    articleidArr.forEach { (id) in
                        group.enter()
                        ApiProvider.request(.getDetail(articleid: id), model: articleContentModel.self) { (res) in
                            self.models.append(res!)
                            group.leave()
                        }
                        _ = group.wait(timeout: DispatchTime.distantFuture)
                    }
                    group.notify(queue: DispatchQueue.global()) {
                        print("models is \(self.models)")
                    }
                }
            }
        }
    }
}
