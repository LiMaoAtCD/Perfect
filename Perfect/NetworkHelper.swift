//
//  NetworkHelper.swift
//  Perfect
//
//  Created by limao on 16/6/12.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyUserDefaults


let url = "http://101.200.131.198:8090/custwine/gw?cmd="

enum httpMethod {
    case GET
    case POST
}
enum URLConstant: String {
    case FirstPage = "queryAppIndexStaticContent"
    
    var contant: String {
        return url + self.rawValue
    }
}



class NetworkHelper: NSObject {
    static let instance = NetworkHelper()
    private override init() {
        super.init()
    }
//    ["sessionId":Defaults[.sessionID] ?? ""]
    
    
    
    func request<T: DataResponse>(method:httpMethod, url: String, parameters: [String: AnyObject]?,completion completionHandler: (T? -> Void)?, failed failedHandler: (RetErrorCode -> Void)?){
        
        var p = parameters ?? [String:AnyObject]()
        p["sessionID"] = Defaults[.sessionID] ?? ""
        
//        Alamofire.request((method == .GET ? .GET : .POST), url, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseString(completionHandler: { (res) in
//            print(res)
//        })

        Alamofire.request((method == .GET ? Method.GET : Method.POST), url, parameters: p, encoding: ParameterEncoding.URL, headers: nil).responseObject { (response: Response<T, NSError>) in
            if let _ = response.result.error {
                failedHandler?(RetErrorCode.NetworkError)
            } else {
                if let value = response.result.value where value.retCode == RetErrorCode.Success.rawValue {
                    completionHandler?(response.result.value)
                } else if let value = response.result.value where value.retCode != RetErrorCode.Success.rawValue  {
                    failedHandler?(RetErrorCode.init(rawValue: value.retCode)!)
                } else {
                    assertionFailure("network data format error")
                }
            }
            completionHandler?(response.result.value)
        }
    }
}


enum RetErrorCode: Int {
    case Success = 0
    case SystemError = -1
    case PermissionDenied = -2
    case NeedLogin = -3
    case NetworkError = -7
}


extension DefaultsKeys {
    static let sessionID = DefaultsKey<String>("sessionID") // sessionID
}


