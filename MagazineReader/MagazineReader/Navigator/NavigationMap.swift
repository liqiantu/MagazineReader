//
//  NavigationMap.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/11/5.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import SafariServices
import UIKit
import URLNavigator
import HandyJSON

struct NavigationMap {
    static func initialize(navigator: NavigatorType) {
        navigator.register("app://article/Detail/<from>") { (url, values, contex) -> UIViewController? in
            guard let fromStr = values["from"] as? String else { return nil }
            if fromStr == "cate" {
                let dic = contex as! [AnyHashable: Any]
                let model = dic["model"]
                let vc = ArticleDetailViewController()
                vc.model = (model as! magazinDescrModel)
                vc.isLastIssue = true
                return vc
            }
            
            return UIViewController()
        }
    }
    
    private static func webViewControllerFactory(
      url: URLConvertible,
      values: [String: Any],
      context: Any?
    ) -> UIViewController? {
      guard let url = url.urlValue else { return nil }
      return SFSafariViewController(url: url)
    }
    
}
