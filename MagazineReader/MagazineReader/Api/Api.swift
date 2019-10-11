//
//  Api.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/9.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation
import Moya
import MBProgressHUD

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<MyService>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

enum MyService {
    case getAllCategory
}

extension MyService: TargetType {
    
    var baseURL: URL {
        return URL.init(string: "http://lyys.dps.qikan.com/api")!
    }
    
    var path: String {
        switch self {
        case .getAllCategory:
            return "/category/GetAllByKind?kind=2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "sampleData".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .getAllCategory:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "cookie":"ASP.NET_SessionId=514ya5ch0fmzvgyfng0jqkpu; apptoken=Kp39Bq++a3uoGb1tSdrEQ0A/idC8i0Ul9AZQwKXgPtmdOgs7S1gPyLAFMFvhAQwg85dJmOseJMx7DA3llLnWrA==; ticket=B53LWMAsmsUR6eZZRHh1hAQOkK336H270GpK4wHVmt5UOMA8Bgx9yy3YGAvgtlsHKmHpDZ5tNILZvRqts_E0FIWREcfg0mkNmrViQHfv3IaALhZB_DHD8MWKO2P_mjll6XlBplA33k7p8UwxvsX05g=="
        ]
    }

}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
