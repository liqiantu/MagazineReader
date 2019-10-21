//
//  AppConfig.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/21.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation

let token = "apptoken=Kp39Bq++a3uoGb1tSdrEQ0A/idC8i0Ul9AZQwKXgPtmdOgs7S1gPyLAFMFvhAQwg85dJmOseJMx7DA3llLnWrA==; ticket=B53LWMAsmsUR6eZZRHh1hAQOkK336H270GpK4wHVmt5UOMA8Bgx9yy3YGAvgtlsHKmHpDZ5tNILZvRqts_E0FIWREcfg0mkNmrViQHfv3IaALhZB_DHD8MWKO2P_mjll6XlBplA33k7p8UwxvsX05g=="

enum PageInfo: Int {
    case index = 1 // 初始分页index
    case size = 10 // 默认分页size大小
}

var configFontSize: Int {
    get {
        if UserDefaults.standard.object(forKey: "PageSize") != nil {
            return UserDefaults.standard.integer(forKey: "PageSize")
        }else {
            UserDefaults.standard.set(100, forKey: "PageSize")
            return 100
        }
    }
}

