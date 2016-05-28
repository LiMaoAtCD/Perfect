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
