//
//  BaseWebView.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/18.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import WebKit

class BaseWebView: WKWebView {

}

extension BaseWebView {
    func loadLocalResource() {
        let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "AritclePage")!
        self.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        self.load(request)
    }
}
