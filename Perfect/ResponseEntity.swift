//
//  ResponseEntity.swift
//  Perfect
//
//  Created by AlienLi on 16/6/13.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm
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
    
    var imageId: Int64 = 0
    var id: Int64 = 0
    var action: String?
    
    func mapping(map: Map) {
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        action <- map["action"]
    }
}

class FirstGoodsTypeItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var id: Int64 = 0
    var title: String?
    var opened: Bool = false
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        opened <- map["opened"]
    }
}

class FirstButtonItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var imageId: Int64 = 0
    var action: String?
    
    func mapping(map: Map) {
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
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
    var imageId: Int64 = 0
    var fullName: String?
    var id: Int64 = 0
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        marketPrice <- map["marketPrice"]
        price <- map["price"]
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
        fullName <- map["fullName"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
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





//登录    
class LoginEntity: Mappable {
    var memberInfo: memberInfoItem?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        memberInfo <- map["memberInfo"]
    }
}
class memberInfoItem: Mappable {
    var id: Int64 = 0
    var nick : String?
    var name: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nick <- map["nick"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
    }
}

//注册

class RegisterEntity: Mappable {
    var memberInfo: memberInfoItem?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        memberInfo <- map["memberInfo"]
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


//确认下单
class ConfirmOrderEntity: Mappable {
    
    var payToken: String?
    var orderId: Int64 = 0
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        orderId <- (map["orderId"], TransformOfUtils.TransformOfInt64())
        payToken <- map["payToken"]
    }
}


//{
//    "retCode": 0,
//    "sessionId": "f2dd6816-eaae-4fc1-be2a-9854de682bec",
//    "retMsg": "操作成功",
//    "retObj": {
//        "payToken": "1231sfjas;dfjkweiasdfasdf",
//        "orderId": 1
//    }
//}


class TransformOfUtils {
    class func TransformOfInt64() -> TransformOf<Int64, NSObject> {
        let trans =  TransformOf<Int64, NSObject>(fromJSON: {
            var ret: Int64?
            if let numberValue = $0 as? NSNumber {
                ret = numberValue.longLongValue
            } else if let strValue = $0 as? NSString {
                ret = strValue.longLongValue
            }
            return ret
            },
      toJSON: {
        $0.map { NSNumber(longLong: $0)
        } })
        
        return trans
    }
}



class DeliverAddress: Object {
    dynamic var name: String?
    dynamic var cellphone: String?
    dynamic var address: String?
    dynamic var isDefault: Bool = false
    dynamic var id: Int = 0
}


class MemberInfoEntity: Mappable {
    var phone: String?
    var username:  String?
    var type: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        type <- map["type"]
        phone <- map["phone"]
    }
}


class AreaIDEntity: Mappable {
    var areas: [AreaIDItemEntity]?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        areas <- map["areas"]
    }

}

class AreaIDItemEntity: Object, Mappable {
    dynamic var name: String?
    dynamic var fullName:  String?
    dynamic var id: Int = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["fullName"]
        name <- map["name"]
    }
}








