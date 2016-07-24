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
    var name: String?
    
    func mapping(map: Map) {
        imageId <- (map["imageId"], TransformOfUtils.TransformOfInt64())
        linkAction <- map["linkAction"]
        name <- map["name"]
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
    var name: String?
    var id: Int64 = 0
    var thumbnailId: Int64 = 0
    var fullName: String?

    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        marketPrice <- map["marketPrice"]
        price <- map["price"]
        thumbnailId <- (map["thumbnailId"], TransformOfUtils.TransformOfInt64())
        name <- map["name"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        fullName <- map["fullName"]
    }
}


//商品详情

class ProductDetailEntity: Mappable {
    var id: Int64 = 0
    var deliverMemo: String?
    var marketPrice: Float = 0
    var price: Float = 0
    var merchantName: String?
    var images: [Int64]?
    
    var name: String?
    var favorite: Bool = false
    var intro: String?
    var products: [ProductDetailModuleItem]?
    var discount: Float = 0.0
    var profile: String?
    var minQuantity: Int = 1
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        deliverMemo <- map["deliverMemo"]
        profile <- map["profile"]

        marketPrice <- map["marketPrice"]
        price <- map["price"]
        merchantName <- map["merchantName"]
        images <- (map["images"],TransformOfUtils.TransformOfInt64())
        name <- map["name"]
        favorite <- map["favorite"]
        intro <- map["intro"]
        discount <- map["discount"]
        products <- map["products"]
        minQuantity <- map["minQuantity"]

    }
}

class ProductDetailModuleItem: Mappable {

    var id: Int64 = 0
    var imgId: Int64 = 0
    var price: Float = 0.0
    var name: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id <- (map["id"],TransformOfUtils.TransformOfInt64())
        imgId <- (map["imgId"],TransformOfUtils.TransformOfInt64())
        price <- map["price"]
        name <- map["name"]
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
    var id: Int64 = 0
    var avatarImgId: Int64 = 0
    var nick : String?
    var name: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nick <- map["nick"]
        avatarImgId <- (map["avatarImgId"], TransformOfUtils.TransformOfInt64())
        id <- (map["id"], TransformOfUtils.TransformOfInt64())

    }
}

//历史订单（全部订单）

class HistoryOrderEntity: Mappable {
    var total: Int = 0
    var rows: [HistoryOrderItem]?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        rows <- map["rows"]
    }
}

class HistoryOrderItem: Mappable {
    required init?(_ map: Map) {}

    var orderStepTextColor: String?
    var orderStepName: String?
    var paymentMethodCode: String?
    var paymentTime: String?
    var orderOrderStatus: String?
    var orderCreateDate: String?
    var paymentMethodName: String?
    var orderSn: String?
    var customImageId: Int64 = 0
    var productId: Int64 = 0
    var orderStepCode: String?
    var price: Float = 0.0
    
//    var orderStatusName: String?
    var address: HistoryOrderItemAddress?

    var productImageId: Int64 = 0
    var quantity: Int = 0
    var productName: String?
    var goodsName: String?
    var orderId: Int64 = 0
    var totalPrice: Float = 0.0
//    var buttons: [HistoryOrderItemButtonItem]?
    
    func mapping(map: Map) {
        
        orderStepTextColor <- map["orderStepTextColor"]
        orderStepName <- map["orderStepName"]
//        orderStatusName <- map["orderStatusName"]
        paymentMethodCode <- map["paymentMethodCode"]
        paymentMethodName <- map["paymentMethodName"]
        address <- map["address"]
        orderStepCode <- map["orderStepCode"]
        productImageId <- (map["productImageId"], TransformOfUtils.TransformOfInt64())
        paymentTime <- map["paymentTime"]
        orderCreateDate <- map["orderCreateDate"]
        orderOrderStatus <- map["orderOrderStatus"]
        quantity <- map["quantity"]
        orderSn <- map["orderSn"]
        productName <- map["productName"]
        goodsName <- map["goodsName"]
        orderId <- (map["orderId"], TransformOfUtils.TransformOfInt64())
        price <- map["price"]
        totalPrice <- map["totalPrice"]
        productId <- (map["productId"], TransformOfUtils.TransformOfInt64())
        customImageId <- (map["customImageId"], TransformOfUtils.TransformOfInt64())
//        buttons <- map["buttons"]
    }
}

//class HistoryOrderItemButtonItem: Mappable {
//    required init?(_ map: Map) {}
//    var code: String?
//    var text: String?
//    
//    func mapping(map: Map) {
//        code <- map["code"]
//        text <- map["text"]
//    }
//}



class HistoryOrderItemAddress: Mappable {
    var areaName: String?
    var areaFullName: String?
    var areaId: Int64 = 0
    var consignee: String?
    var address: String?
    var phone: String?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        phone <- map["phone"]
        address <- map["address"]
        areaName <- map["areaName"]
        consignee <- map["areaName"]
        areaFullName <- map["areaFullName"]
        areaId <- (map["areaId"], TransformOfUtils.TransformOfInt64())
    }
}


//MARK: 订单详情
class OrderDetailEntity: Mappable {
    
    var moduleId: Int64 = 0
    var status: Int = 0
    var statusName: String?
    var moduleName: String?
    var image: Int64 = 0
    var statusTextColor: String?
    var orderNo: String?
    var price: Float = 0.0
    var address: HistoryOrderItemAddress?
    var quantity: Int = 0
    var fullName: String?
    var orderId: Int64 = 0
    var totalPrice: Float = 0.0
    var orderTime: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        moduleId <- (map["moduleId"], TransformOfUtils.TransformOfInt64())
        price <- map["price"]
        status <- map["status"]
        statusName <- map["statusName"]
        moduleName <- map["moduleName"]
        statusTextColor <- map["statusTextColor"]
        orderNo <- map["orderNo"]
        image <- (map["image"], TransformOfUtils.TransformOfInt64())
        address <- map["address"]
        quantity <- map["quantity"]
        fullName <- map["fullName"]
        orderId <- (map["orderId"], TransformOfUtils.TransformOfInt64())
        totalPrice <- map["totalPrice"]
        orderTime <- map["orderTime"]
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
    
    var orderId: Int64 = 0
    var paymentData: String?
    var paymentMethodCode: String?
    var orderSn: String?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        orderId <- (map["orderId"], TransformOfUtils.TransformOfInt64())
        paymentData <- map["paymentData"]
        paymentMethodCode <- map["paymentMethodCode"]
        orderSn <- map["orderSn"]
    }
}


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

//"retObj": {
//    "id": 102,
//    "birth": "",
//    "phone": "13568927473",
//    "username": "13568927473",
//    "avatarId": 112,
//    "attributeValue1": null,
//    "attributeValue2": null,
//    "attributeValue3": null,
//    "name": "d大口大口",
//    "gender": null,
//    "type": "person"
//}


class MemberInfoEntity: Mappable {
    var phone: String?
    var username:  String?
    var type: String?
    var birth: String?
    var gender: String?
    var name: String?
    var avatarId: Int64 = 0
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        phone <- map["phone"]
        username <- map["username"]
        name <- map["name"]
        type <- map["type"]
        birth <- map["birth"]
        gender <- map["gender"]
        avatarId <- (map["avatarId"], TransformOfUtils.TransformOfInt64())
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

class CollectProductEntity: Mappable {
    var total: Int = 0
    var rows: [CollectProductItem]?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        rows <- map["rows"]
    }
}

//"id": 1,
//"categoryName": "白酒",
//"marketPrice": 479.424,
//"price": 2343.52,
//"categoryId": 1,
//"name": "泸州老窖 1573",
//"thumbnailId": 6,
//"discount": 1.0

class CollectProductItem: Mappable {
    
    var marketPrice: Float = 0.0
    var price: Float = 0.0
    var thumbnailId: Int64 = 0
    var categoryId: Int64 = 0
    var categoryName: String?
    var name: String?
    var fullName: String?
    var id: Int64 = 0
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        marketPrice <- map["marketPrice"]
        price <- map["price"]
        thumbnailId <- (map["thumbnailId"], TransformOfUtils.TransformOfInt64())
        categoryId <- (map["categoryId"], TransformOfUtils.TransformOfInt64())
        categoryName <- map["categoryName"]
        name <- map["name"]
        fullName <- map["fullName"]
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        
    }
}


class UploadImageEntity: Mappable {
    var imgId: Int64 = 0
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        imgId <- (map["imgId"], TransformOfUtils.TransformOfInt64())
    }
}



//MARK: -文章
class ArticleEntity: Mappable {
    var total: Int = 0
    var rows: [ArticleItem]?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        rows <- map["rows"]
    }

}

class ArticleItem: Mappable {
    var id: Int64 = 0
    var title: String?
    var thumbnail: Int64 = 0
    var readMark: Bool = false
    var linkAction: String?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOfUtils.TransformOfInt64())
        title <- map["title"]
        thumbnail <- (map["thumbnail"], TransformOfUtils.TransformOfInt64())
        readMark <- map["readMark"]
        linkAction <- map["linkAction"]

    }
}



