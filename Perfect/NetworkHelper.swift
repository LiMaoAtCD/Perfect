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
    
    
    
    func request<T: DataResponse>(method:httpMethod, url: String, parameters: [String: AnyObject]?, completionHandler: (T? -> Void)?){
        
        var p = parameters ?? [String:AnyObject]()
        p["sessionID"] = Defaults[.sessionID] ?? ""
        
//        Alamofire.request((method == .GET ? .GET : .POST), url, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseString(completionHandler: { (res) in
//            print(res)
//        })
        
        Alamofire.request(.GET, url, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseObject { (response: Response<T, NSError>) in
            completionHandler?(response.result.value)
        }
    }
}


extension DefaultsKeys {
    static let sessionID = DefaultsKey<String>("sessionID") // sessionID
}


