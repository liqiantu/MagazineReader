//
//  Api.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/9.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import MBProgressHUD

// 加载插件
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
        urlRequest.timeoutInterval = 5
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<MyService>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<MyService>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum MyService {
    case getAllCategory
    case getMagazineByCategory(categorycode: String)
}

extension MyService: TargetType {
    
    var baseURL: URL {
        return URL.init(string: "http://lyys.dps.qikan.com/api")!
    }
    
    var path: String {
        switch self {
        case .getAllCategory: return "/category/GetAllByKind"
        case .getMagazineByCategory: return "/magazine/GetMagazineByCategory"
        default: break
        }
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        switch self {
        case .getAllCategory:
            parameters = ["kind":2]
        case let .getMagazineByCategory(categorycode):
            parameters = ["categorycode": categorycode,
                          "magazinetype": 2,
                          "pagesize": 6,
                          "pageindex": 1,
                          "itemcount": 0]
        default: break
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    }
    
    var headers: [String : String]? {
        return [
            "cookie": token
        ]
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "sampleData".utf8Encoded
    }

}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func request<T>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.Data)
        })
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
