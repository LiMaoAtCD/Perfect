//
//  NetworkHelper.swift
//  Perfect
//
//  Created by limao on 16/6/12.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import Alamofire

let url = "http://101.200.131.198:8090/custwine/gw?"

enum URLConstant: String {
    case FirstPage = "queryAppIndexStaticContent"
    
    var contant: String {
        return url + self.rawValue
    }
}

enum httpMethod {
    case GET
    case POST
}

class NetworkHelper: NSObject {
    static let instance = NetworkHelper()
    
    private override init() {
        super.init()
    }
    
    func request(method:httpMethod, url: String, parameters: [String: AnyObject]? ){
        Alamofire.request((method == .GET ? .GET : .POST), URLConstant.FirstPage.contant, parameters: ["session":""], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            response.data
        }
    }
}
