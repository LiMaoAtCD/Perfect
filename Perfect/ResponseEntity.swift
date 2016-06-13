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
    var types: [FirstGoodsTypes]?
    var buttons: [FirstButtons]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        topBanners <- map["topBanners"]
        types <- map["types"]
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

class FirstGoodsTypes: Mappable{
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    var id: String?
    var title: String?
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
    }
}

class FirstButtons: Mappable{
    
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