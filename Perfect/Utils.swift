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
    
    static var logined: Bool {
        get {
            return Defaults[.logined]
        }
        
        set {
            Defaults[.logined] = newValue
        }
    }
    
    static var shouldSwitch: Bool {
        get {
            return Defaults[.shouldSwitch]
        }
        
        set {
            Defaults[.shouldSwitch] = newValue
        }
    }
}

extension DefaultsKeys {
    static let logined = DefaultsKey<Bool>("logined")
    static let sessionID = DefaultsKey<String>("sessionID") // sessionID
    static let shouldSwitch = DefaultsKey<Bool>("shouldSwitch")
    static let password = DefaultsKey<String>("password")
}

extension UIView {
    var x: CGFloat { return self.frame.origin.x}
    var y: CGFloat { return self.frame.origin.y}
    var w: CGFloat { return self.frame.size.width}
    var h: CGFloat { return self.frame.size.height}
    
}


//
struct Tool {
    static let width = UIScreen.mainScreen().bounds.size.width
    static let sb = UIStoryboard.init(name: "Main", bundle: nil)
    static let root = UIApplication.sharedApplication().keyWindow?.rootViewController as! RootNavigationController

}


extension String {
    
    var isValidCellPhone: Bool {
        let string: NSString = NSString(string: self)
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(string) == true)
            || (regextestcm.evaluateWithObject(string)  == true)
            || (regextestct.evaluateWithObject(string) == true)
            || (regextestcu.evaluateWithObject(string) == true))
        {
            return true
        } else
        {
            return false
        }
    }
}

extension String {
    var isValidPassword: Bool {
        return self =~ "^[a-zA-Z0-9]{6,16}$"
    }
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
