//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import URLNavigator

class UTabBarController: UITabBarController {
    private let navigator: NavigatorType

    init(navigator: NavigatorType) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        let favVC = FavouriteViewController()
        addChildViewController(favVC, title: "书架", image: "tab_book", selectedImage: "tab_book_S")
        
        let cateVC = CateViewController()
        cateVC.navigator = navigator
        addChildViewController(cateVC, title: "分类", image: "tab_class", selectedImage: "tab_class_S")
        
        let mineVC = MineViewController()
        addChildViewController(mineVC, title: "我的", image: "tab_mine", selectedImage: "tab_mine_S")
        
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:String? ,selectedImage:String?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage.init(named: image!)?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: UIImage.init(named: selectedImage!)?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }
    
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
