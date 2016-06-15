//
//  ResponseEntity.swift
//  Perfect
//
//  Created by AlienLi on 16/6/13.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ObjectMapper


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
    
    var imgUrl: String?
    var id: String?
    var action: String?
    
    func mapping(map: Map) {
        imgUrl <- map["imgUrl"]
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
    
    var imgUrl: String?
    var action: String?
    
    func mapping(map: Map) {
        imgUrl <- map["imgUrl"]
        action <- map["action"]
    }
}