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
    var linkAction: String?
    
    func mapping(map: Map) {
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        linkAction <- map["linkAction"]
    }
}

class FirstGoodsTypeItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var id: Int64 = 0
    var title: String?
    var isDefault: Bool = false
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        isDefault <- map["isDefault"]
    }
}

class FirstButtonItem: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var imageId: Int64 = 0
    var linkAction: String?
    
    func mapping(map: Map) {
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
        linkAction <- map["linkAction"]
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



class AreaTreeEntity: Object, Mappable {
    
    dynamic var areaTreeVer: Int64 = 0
    private var temp: [ProviceItem] {
        set{
            areaTree.removeAll()
            areaTree.appendContentsOf(newValue)
        }
        get{
            return Array(areaTree)
        }
    }
    let areaTree = List<ProviceItem>()
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        areaTreeVer <- (map["areaTreeVer"], TransformOfUtils.TransformOfInt64())
        temp <- map["areaTree"]
    }
    
    override static func primaryKey() -> String? {
        return "areaTreeVer"
    }
    
    
}

class ProviceItem: Object,Mappable {
    dynamic var n: String?
    dynamic var i:  Int64 = 0
    private var temp: [CityItem] {
        set{
            c.removeAll()
            c.appendContentsOf(newValue)
        }
        get{
            return Array(c)
        }
    }
    let c = List<CityItem>()
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        n <- map["n"]
        i <- (map["i"],TransformOfUtils.TransformOfInt64())
        temp <- map["c"]
    }
}

class CityItem: Object,Mappable {
    dynamic var n: String?
    dynamic var i:  Int64 = 0
    private var temp: [CountyItem] {
        set{
            c.removeAll()
            c.appendContentsOf(newValue)
        }
        get{
            return Array(c)
        }
    }
    let c = List<CountyItem>()
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        n <- map["n"]
        i <- (map["i"],TransformOfUtils.TransformOfInt64())
        temp <- map["c"]
    }
}

class CountyItem: Object ,Mappable {
    dynamic var n: String?
    dynamic var i:  Int64 = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        n <- map["n"]
        i <- (map["i"],TransformOfUtils.TransformOfInt64())
    }
}



//MARK: 收获地址

class AddressEntity: Object, Mappable {
    let addresses = List<AddressItemsEntity>()
    private var temp: [AddressItemsEntity] {
        set{
            addresses.removeAll()
            addresses.appendContentsOf(newValue)
        }
        get{
            return Array(addresses)
        }
    }
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        temp <- map["addresses"]
    }
}

class AddressItemsEntity:Object, Mappable {
    dynamic var id: Int64 = 0
    dynamic var contactPhone: String?
    dynamic var contactId: Int64 = 0
    dynamic var areaFullName: String?
    dynamic var areaName: String?
    dynamic var isDefault: Bool = false
    dynamic var contactName: String?
    dynamic var areaId: Int64 = 0
    dynamic var contactAddress: String?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"],TransformOfUtils.TransformOfInt64())
        contactPhone <- map["contactPhone"]
        contactId <- (map["contactId"],TransformOfUtils.TransformOfInt64())
        areaFullName <- map["areaFullName"]
        areaName <- map["areaName"]
        isDefault <- map["isDefault"]
        contactName <- map["contactName"]
        areaId <- (map["areaId"],TransformOfUtils.TransformOfInt64())
        contactAddress <- map["contactAddress"]
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}





