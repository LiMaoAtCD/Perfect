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
