//
//  AppDelegate.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/7.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://www.baidu.com")
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configBase()
        FMDBToolSingleton.sharedInstance.configDB()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = UTabBarController()
        
        return true
    }
    
    func configBase() {
        //MARK: 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        //MARK: 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
                print("正在使用移动数据")
            case .notReachable:
                print("未联网")
            default: break
            }
        }
        reachability?.startListening()
    }

}

