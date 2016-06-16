//
//  Utils.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static let shared = Utils()
    
    class var isLogin: Bool {
        get {
            
            let islogin = NSUserDefaults.standardUserDefaults().boolForKey("isLogin")
            return islogin
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLogin")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private override init() {
        
    }
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
}
