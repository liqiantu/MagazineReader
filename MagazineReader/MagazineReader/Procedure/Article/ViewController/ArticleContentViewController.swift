//
//  ArticleContentViewController.swift
//  MagazineReader
//
//  Created by 李前途 on 2019/10/17.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import WebKit

class ArticleContentViewController: UBaseViewController {
    private var fontSize = configFontSize

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration.init()
        let wv = WKWebView.init(frame: CGRect.zero, configuration: config)
        wv.scrollView.alwaysBounceVertical = true
        wv.navigationDelegate = self
        wv.scrollView.delegate = self
        wv.loadLocalResource()
        return wv
    }()
    
    var model: articleModel?
    var models: [articleContentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.model?.Title
        navigationController?.hidesBarsOnSwipe = true
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem.init(title: "加大", style: UIBarButtonItem.Style.plain, target: self, action: #selector(plus)),
            UIBarButtonItem.init(title: "减小", style: UIBarButtonItem.Style.plain, target: self, action: #selector(reduce))
        ]
    }
    
    @objc func plus() {
        fontSize += 10
        UserDefaults.standard.set(fontSize, forKey: "PageSize")
        let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(fontSize)%'"
        webView.evaluateJavaScript(js) { (res, err) in
            print("res is \(String(describing: res))")
            print("err is \(String(describing: err))")
        }
    }
    
    @objc func reduce() {
        fontSize -= 10
        UserDefaults.standard.set(fontSize, forKey: "PageSize")
        let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(fontSize)%'"
        webView.evaluateJavaScript(js) { (res, err) in
            print("res is \(String(describing: res))")
            print("err is \(String(describing: err))")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func configUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.usnp.edges)
        }
    }
    
    func loadData() {
        ApiLoadingProvider.request(.getDetail(articleid: model!.ArticleID!), model: articleContentModel.self) { (result) in
            guard let res = result else { return }
            self.models.append(res)
            let count = res.PageCount - 1
            if count > 0 {
                var articleidArr = [String]()
                for index in 1...count {
                    let str = "\(self.model!.ArticleID!)-\(String(index))"
                    articleidArr.append(str)
                }
                // 内容多个分页
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
                        DispatchQueue.main.async {
//                            print(self.models)
                            self.injectData()
                        }
                    }
                }
            }else {
                self.injectData()
            }
        }
    }
    
    func injectData() {
        let jsonDic = self.models.toJSON()
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDic as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonStr = String.init(data: jsonData, encoding: String.Encoding.utf8)
        guard let js = jsonStr else { return }
        
        let adjustFontJs = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(self.fontSize)%'"
        self.webView.evaluateJavaScript(adjustFontJs) { (res, err) in
            print("res is \(String(describing: res))")
            print("err is \(String(describing: err))")
            
            self.webView.evaluateJavaScript("reloadData(\(js))") { (res, err) in
                print("res is \(String(describing: res))")
                print("err is \(String(describing: err))")
            }
        }
    }
}

extension ArticleContentViewController: WKNavigationDelegate {
    ///在网页加载完成时调用js方法
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadData()
    }
}

extension ArticleContentViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pan = scrollView.panGestureRecognizer
//        let velocity = pan.velocity(in: scrollView).y
//        if velocity < -5 {
//            self.navigationController?.setNavigationBarHidden(true,animated:true)
//        }else if velocity > 5 {
//            self.navigationController?.setNavigationBarHidden(false,animated:true)
//        }
//    }
}
