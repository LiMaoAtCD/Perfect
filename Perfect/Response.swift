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

//注册

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












