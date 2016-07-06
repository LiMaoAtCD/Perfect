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
import SVProgressHUD


let url = "http://101.200.131.198:8090/custwine/gw?cmd="

let ArticleURL = "http://101.200.131.198:8090/custwine/article/mobile/"
let NetWorkImageUrl = "http://101.200.131.198:8090/custwine/dimg/"
let GoodDetailURL = "http://101.200.131.198:8090/custwine/goods/mobile/"

let avatarUploadURL = "http://101.200.131.198:8090/custwine/dimg/upload"

//文章读取地址为： http://服务器地址/article/mobile/id.page
//例如：
//http://101.200.131.198:8090/custwine/article/mobile/1.page

//图片访问方式为：
//"http://地址/dimg/id_图片宽_图片最大高_是否裁减(1/0).png
//示例：http://101.200.131.198:8090/custwine/dimg/1_1_1_0.png"


//示例：http://101.200.131.198:8090/custwine/dimg/upload
//参数：category-图片分类，avatar-头像,custwine-定制酒
//fileTitle-图片名称
//fileIntro-图片说明（可不传）
//file:通过POST传递的图片文件

enum httpMethod {
    case GET
    case POST
}
enum URLConstant: String {
    case hello = "hello"
    case appQueryIndexStaticContent = "appQueryIndexStaticContent" //首页上部
    case appQueryGoodsList = "appQueryGoodsList"    //首页下部
    case appGoodsDetail = "appGoodsDetail"  //商品详情
    case appMemberCenterIndex = "appMemberCenterIndex" //个人
    case appSubOrder = "appSubOrder" //提交订单
    case Register = "memberRegister" //注册
    case getMobileValidCode = "getMobileValidCode" //验证码
    case appConfirmOrder = "appConfirmOrder"//确认订单
    case appOrderHistory = "appOrderHistory" //历史订单
    case resetPasswordByMobile = "resetPasswordByMobile" // 重置密码
    case updateLoginMemberPassword = "updateLoginMemberPassword"//修改密码
    case memberLogin = "memberLogin"
    case updateLoginMemberInfo = "updateLoginMemberInfo" //更新个人信息
    case getLoginMemberInfo = "getLoginMemberInfo" // 获取用户信息
    case getSubAreas = "getSubAreas"
    case getAreasTreeJson = "getAreasTreeJson" //获取quyuID
    case setLoginMemberDefaultDeliveryAddress = "setLoginMemberDefaultDeliveryAddress"
    case getLoginMemberDeliveryAddresses = "getLoginMemberDeliveryAddresses"
    case deleteLoginMemberDeliveryAddress = "deleteLoginMemberDeliveryAddress"
    case saveOrUpdateLoginMemberDeliveryAddress = "saveOrUpdateLoginMemberDeliveryAddress"
    case appOrderDetail = "appOrderDetail"
    case setLoginMemberGoodsFavorite = "setLoginMemberGoodsFavorite"
    case getLoginMemberFavoriteGoodsList = "getLoginMemberFavoriteGoodsList"
    case appArticleList = "appArticleList"
    var contant: String {
        return url + self.rawValue
    }
}



class NetworkHelper: NSObject {
    static let instance = NetworkHelper()
    private override init() {
        super.init()
    }
    
    func request<T: DataResponse>(method:httpMethod, url: String, parameters: [String: AnyObject]?,completion completionHandler: (T? -> Void)?, failed failedHandler: ((String?,Int) -> Void)?){
        
        var p = parameters ?? [String:AnyObject]()
        p["sessionId"] = Defaults[.sessionID] ?? ""

        Alamofire.request((method == .GET ? Method.GET : Method.POST), url, parameters: p, encoding: ParameterEncoding.URL, headers: nil).responseObject { (response: Response<T, NSError>) in
            if let _ = response.result.error {
                failedHandler?("网络连接失败", RetErrorCode.NetworkError.rawValue)
            } else {
                if let value = response.result.value where value.retCode == RetErrorCode.Success.rawValue {
                    completionHandler?(response.result.value)
                    if let session = response.result.value?.sessionId {
                        Defaults[.sessionID] = session
                    }
                } else if let value = response.result.value where value.retCode == RetErrorCode.NeedLogin.rawValue  {
                    SVProgressHUD.dismiss()
                    AppDelegate.login()
                } else if let value = response.result.value where value.retCode != RetErrorCode.Success.rawValue {
                    failedHandler?(value.retMsg, value.retCode)
                } else {
                    assertionFailure("network data format error")
                }
            }
            }     //Debug
//            .responseString { (response) in
//                print(response.result.value)
//        }
    }


    func uploadImage<T: DataResponse>(image: UIImage, forType parameters: [String: String]?, completion completionHandler: (T? -> Void)?, failed failedHandler: ((String?,Int) -> Void)?){
        
        Alamofire.upload(.POST, avatarUploadURL, multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                multipartFormData.appendBodyPart(data: imageData, name: "file", fileName: "file.png", mimeType: "image/png")
            }
            if let _ = parameters {
                for (key, value) in parameters! {
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                }
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseObject(completionHandler: { (response: Response<T, NSError>) in
                        
                            if let _ = response.result.error {
                                failedHandler?("网络连接失败", RetErrorCode.NetworkError.rawValue)
                            } else {
                                if let value = response.result.value where value.retCode == RetErrorCode.Success.rawValue {
                                    completionHandler?(response.result.value)
                                    if let session = response.result.value?.sessionId {
                                        Defaults[.sessionID] = session
                                    }
                                } else if let value = response.result.value where value.retCode == RetErrorCode.NeedLogin.rawValue  {
                                    SVProgressHUD.dismiss()
                                    AppDelegate.login()
                                } else if let value = response.result.value where value.retCode != RetErrorCode.Success.rawValue {
                                    failedHandler?(value.retMsg, value.retCode)
                                } else {
                                    assertionFailure("network data format error")
                                }
                            }
                    })
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    
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



