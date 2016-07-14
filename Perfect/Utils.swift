//
//  Utils.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

struct Util {
//    
    static var logined: Bool {
        get {
            return Defaults[.logined]
        }
        
        set {
            Defaults[.logined] = newValue
        }
    }

    
}




//
struct Tool {
    static let width = UIScreen.mainScreen().bounds.size.width
    static let sb = UIStoryboard.init(name: "Main", bundle: nil)
    static let root = UIApplication.sharedApplication().keyWindow?.rootViewController as! RootNavigationController
    static let height = UIScreen.mainScreen().bounds.size.height
    

}

struct RegexHelper {
    let regex: NSRegularExpression
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
    func match(input: String) -> Bool {
        let matches = regex.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

infix operator =~ {
associativity none
precedence 130
}

func =~ (lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}
