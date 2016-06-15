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





