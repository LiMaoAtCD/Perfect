//
//  ResponseEntity.swift
//  Perfect
//
//  Created by AlienLi on 16/6/13.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ObjectMapper

// 首页
class FirstEntity: Mappable {
    
    var topBanners: [FirstBannerItem]?
    var types: [FirstGoodsTypeItem]?
    var buttons: [FirstButtonItem]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        topBanners <- map["topBanners"]
        types <- map["goodsTypes"]
        buttons <- map["buttons"]
    }
    
}

class FirstBannerItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var imageId: String?
    var id: String?
    var action: String?
    
    func mapping(map: Map) {
        imageId <- map["imageId"]
        id <- map["id"]
        action <- map["action"]
    }
}

class FirstGoodsTypeItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var id: String?
    var title: String?
    var opened: Bool = false
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
        opened <- map["opened"]
    }
}

class FirstButtonItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var imageId: String?
    var action: String?
    
    func mapping(map: Map) {
        imageId <- map["imageId"]
        action <- map["action"]
    }
}

//商品

class ProductEntity: Mappable {
    var total: Int = 0
    var rows: [ProductItem]?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        rows <- map["rows"]
    }
}

class ProductItem: Mappable {
    
    var marketPrice: Float = 0.0
    var price: Float = 0.0
    var imageId: String?
    var fullName: String?
    
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        marketPrice <- map["marketPrice"]
        price <- map["price"]
        imageId <- map["imageId"]
        fullName <- map["fullName"]
    }
}


//商品详情

class ProductDetailEntity: Mappable {
    var deliverMemo: String?
    var deliverRegionGroup: Int = 0
    var marketPrice: Float = 0
    var price: Float = 0
    var merchantName: String?
    var images: [String]?
    
    var fullName: String?
    var favorite: Bool = false
    var intro: String?
    
    var tabs:[ProductDetailSectionItem]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        deliverMemo <- map["deliverMemo"]
        deliverRegionGroup <- map["deliverRegionGroup"]
        marketPrice <- map["marketPrice"]
        price <- map["price"]
        merchantName <- map["merchantName"]
        images <- map["images"]
        fullName <- map["fullName"]
        favorite <- map["favorite"]
        intro <- map["intro"]
        tabs <- map["tabs"]
    }
}

class ProductDetailSectionItem: Mappable {
    var content: [ProductDetailIntroItem]?
    var title: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
}

class ProductDetailIntroItem: Mappable {
    var value: String?
    var type: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        value <- map["value"]
        type <- map["type"]
    }

}




//个人中心 
class PersonalEntity: Mappable {
    var memberInfo: PersonalMemberInfoItem?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        memberInfo <- map["memberInfo"]
    }
}

class PersonalMemberInfoItem: Mappable {
    var id: Int = 0
    var avatarImgId: Int = 0
    var nick : String?
    var name: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nick <- map["nick"]
        avatarImgId <- map["avatarImgId"]
        id <- map["id"]

    }
}


//注册

class RegisterEntity: Mappable {
    var memberInfo: RegisterItem?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        memberInfo <- map["memberInfo"]
    }
}

class RegisterItem: Mappable {
    var id: Int = 0
    var nick : String?
    var name: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nick <- map["nick"]
        id <- map["id"]
    }
}

//获取验证码

class ValidCodeEntity: Mappable {
//    var memberInfo: RegisterItem?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
//        memberInfo <- map["memberInfo"]
    }
}









