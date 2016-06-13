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
    
    
    func mapping(map: Map) {
        retCode <- map["retCode"]
        sessionId <- map["sessionId"]
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


//class ListTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
//    typealias Object = List<T>
//    typealias JSON = [AnyObject]
//    
//    let mapper = Mapper<T>()
//    
//    func transformFromJSON(value: AnyObject?) -> Object? {
//        let results = List<T>()
//        if let value = value as? [AnyObject] {
//            for json in value {
//                if let obj = mapper.map(json) {
//                    results.append(obj)
//                }
//            }
//        }
//        return results
//    }
//    
//    func transformToJSON(value: Object?) -> JSON? {
//        var results = [AnyObject]()
//        if let value = value {
//            for obj in value {
//                let json = mapper.toJSON(obj)
//                results.append(json)
//            }
//        }
//        return results
//    }
//}
