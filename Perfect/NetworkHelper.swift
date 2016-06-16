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
    case FirstPage = "appQueryIndexStaticContent" //首页上部
    case ProductList = "appQueryProductList"    //首页下部
    case appProductDetail = "appProductDetail"  //商品详情
    case appMemberCenterIndex = "appMemberCenterIndex" //个人
    case appSubOrder = "appSubOrder" //提交订单
    
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
    
    
    
    func request<T: DataResponse>(method:httpMethod, url: String, parameters: [String: AnyObject]?,completion completionHandler: (T? -> Void)?, failed failedHandler: (String? -> Void)?){
        
        var p = parameters ?? [String:AnyObject]()
        p["sessionID"] = Defaults[.sessionID] ?? ""
        

        Alamofire.request((method == .GET ? Method.GET : Method.POST), url, parameters: p, encoding: ParameterEncoding.URL, headers: nil).responseObject { (response: Response<T, NSError>) in
            if let _ = response.result.error {
                failedHandler?("网络连接失败")
            } else {
                if let value = response.result.value where value.retCode == RetErrorCode.Success.rawValue {
                    completionHandler?(response.result.value)
                    if let session = response.result.value?.sessionId {
                        Defaults[.sessionID] = session
                    }
                    
                } else if let value = response.result.value where value.retCode != RetErrorCode.Success.rawValue  {
//                    failedHandler?(RetErrorCode.init(rawValue: value.retCode)!)
                    failedHandler?(value.retMsg)

                } else {
                    assertionFailure("network data format error")
                }
            }
            completionHandler?(response.result.value)
        }
//            .responseString { (res) in
//            print(res)
//        }
    }
}




//0
//操作成功
//-6
//数据读写失败
//-5
//格式交验不通过
//-4
//权限不足
//-3
//操作对象无效
//-2
//请登录后再操作
//-1
//系统错误

enum RetErrorCode: Int {
    case Success = 0
    case SystemError = -1
    case NeedLogin = -2
    case ObjectInvalid = -3
    case PerssionDeny = -4
    case FormatError = -5
    case DataIOError = -6
    case NetworkError = -7
}



