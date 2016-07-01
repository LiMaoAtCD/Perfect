//
//  Response.swift
//  Perfect
//
//  Created by AlienLi on 16/6/13.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ObjectMapper

class DataResponse: Mappable {
    var retCode: Int = 0
    var sessionId: String?
    var retMsg: String?
    
    func mapping(map: Map) {
        retCode <- map["retCode"]
        sessionId <- map["sessionId"]
        retMsg <- map["retMsg"]
    }
    
    required init?(_ map: Map){
    }
}

//首页上部
class FirstPageResponse: DataResponse {
    var retObj: FirstEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
}


//首页商品
class ProductListResponse: DataResponse {
    var retObj: ProductEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
}
//商品详情
class ProductDetailResponse: DataResponse {
    var retObj: ProductDetailEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
}

//个人中心

class PersonalCenterResponse: DataResponse {
    var retObj: PersonalEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }

}


//注册

class RegisterResponse: DataResponse {
    var retObj: RegisterEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
    
}

//登录

class LoginResponse: DataResponse {
    var retObj: LoginEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
    
}

//确认订单
class ConfirmOrderResponse: DataResponse {
    var retObj: ConfirmOrderEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        retObj <- map["retObj"]
    }
    
}

// 个人信息

class MemberInfoResponse : DataResponse {
    var retObj: MemberInfoEntity?

    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}


//获取配送区域
class AreaResponse: DataResponse {
    var retObj: AreaIDEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}

class AreaTreeResponse: DataResponse {
    var retObj: AreaTreeEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}

//MARK: 收获地址
class AddressResponse: DataResponse {
    var retObj: AddressEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}
//MARK: 全部订单
class HistoryOrderResponse: DataResponse {
    var retObj: HistoryOrderEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}


//MARK: 订单详情
class OrderDetailResponse: DataResponse {
    var retObj: HistoryOrderEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}

//MARK: 订单详情
class CollectProductResponse: DataResponse {
    var retObj: CollectProductEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}

//MARK: 上传图片
class UploadImageResponse: DataResponse {
    var retObj: UploadImageEntity?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        retObj <- map["retObj"]
    }
}














