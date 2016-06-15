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
    
    var marketPrice: Int = 0
    var price: Int = 0
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



