//
//  Extensions.swift
//  Perfect
//
//  Created by limao on 16/6/16.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension UIViewController {
    
    class func someController<T: UIViewController>(vc: T.Type,ofStoryBoard storyBoard: String) -> T {
        let vc = UIStoryboard.init(name: storyBoard, bundle: nil).instantiateViewControllerWithIdentifier(String.init(T)) as! T
        return vc
    }
    
    func configurePopNavigationItem() {
        let image = UIImage(named: "navi_back")
        let backButton = UIButton(type: .Custom)
        backButton.setImage(image, forState: .Normal)
        backButton.frame = CGRectMake(0, 0, image!.size.width, image!.size.height)
        backButton.addTarget(self, action: #selector(UIViewController.pop), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
//        self.navigationController?.navigationBar.shadowImage = UIImage.init(named: "navi_shadow")

        self.navigationController?.navigationBar.translucent = false
    }
    
    func pop() {
        if self.navigationController?.viewControllers.count > 1 {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func showAlertWithMessage(message: String?, block: (Void -> Void)?) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (_) -> Void in
            if let _ = block {
                block!()
            }
        }
        
        alertController.addAction(action)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}

extension UIStoryboard {
    @nonobjc static let main = "Main"
}

extension String {
    var actionID: Int64 {
        let arr = self.componentsSeparatedByString(":")
        if arr.count > 0 {
            let id = Int64(arr.last!)
            return id ?? 0
        } else {
            return 0
        }
    }
    var actionType: String {
        let arr = self.componentsSeparatedByString(":")
        if arr.count > 0 {
            let type = arr[1]
            return type
        } else {
            return ""
        }
    }
    
    var isValidPassword: Bool {
        return self =~ "^[a-zA-Z0-9]{6,16}$"
    }
}

extension UIViewController {
    class func gotoAction(linkAction: String, from currentController: UIViewController) {
    
        if linkAction == "" {
            print("找服务端")
            return
        }
        let actionType = linkAction.actionType
        let id = linkAction.actionID
        let type = ActionType(rawValue: actionType)!
        switch type {
        case .showGoodsListByTag:
            let detail = CustomTypeViewController.someController(CustomTypeViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.id = id
            detail.hidesBottomBarWhenPushed = true
            currentController.navigationController?.pushViewController(detail, animated: true)
        case .showArticleContent:
            
            let articleVC = ArticleViewController.someController(ArticleViewController.self, ofStoryBoard: UIStoryboard.main)
            articleVC.hidesBottomBarWhenPushed = true
            articleVC.id = id
            currentController.navigationController?.pushViewController(articleVC, animated: true)
        case .showGoodsDetail:
            
            let detail = GoodsDetailViewController.someController(GoodsDetailViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.id = id
            detail.hidesBottomBarWhenPushed = true
            currentController.navigationController?.pushViewController(detail, animated: true)
        
        case .showGoodsListByCategory:
            let detail = CustomTypeViewController.someController(CustomTypeViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.id = id
            detail.hidesBottomBarWhenPushed = true
            currentController.navigationController?.pushViewController(detail, animated: true)
        
        case .showArticleListByCategory:
            break
        case .openUri:
            break
        case .openUrl:
            break
        }

    }
}

enum ActionType: String {
    case showGoodsListByTag = "showGoodsListByTag"
    case showGoodsDetail = "showGoodsDetail"
    case showArticleContent = "showArticleContent"
    case showGoodsListByCategory = "showGoodsListByCategory"
    case showArticleListByCategory = "showArticleListByCategory"
    case openUri = "openUri"
    case openUrl = "openUrl"
}

extension UIImage {
    class func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 100, 100)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColor(context, CGColorGetComponents(color.CGColor))
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


extension Float {
    var currency: String {
        let temp = String(format: "%.2f", self)
        return "￥\(temp)"
    }
}

extension Int64 {
    func perfectImageurl(w: CGFloat, h: CGFloat, crop: Bool) -> String {
        
        return NetWorkImageUrl + String(self) + "_"
            + String(Int(w)) + "_"
            + String(Int(h)) + "_"
            + (crop ? "1" : "0")
            + ".png"
    }
    
    var article: String {
        return ArticleURL + String(self) + ".page"
    }
    
    var toNSNumber: NSNumber {
        return NSNumber.init(longLong: self)
    }
    
    
    var goodDescription: String {
        return GoodDetailURL + String(self) + "/description.page"
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


public typealias TimerExcuteClosure = @convention(block)()->()
extension NSTimer{
    public class func YQ_scheduledTimerWithTimeInterval(ti:NSTimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> NSTimer{
        return self.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, AnyObject.self), repeats: true)
    }
    
    class func excuteTimerClosure(timer: NSTimer)
    {
        let closure = unsafeBitCast(timer.userInfo, TimerExcuteClosure.self)
        closure()
    }
}

extension String {
    
    var isValidCellPhone: Bool {
        let string: NSString = NSString(string: self)
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$"
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

extension Int {
    var pixelToPoint: CGFloat {
        if Tool.height == 1136 / 2 {
            return CGFloat(Float(self) / 2) * 1136 / 1334
        } else if Tool.height == 1920 / 3 {
            return CGFloat(Float(self) / 2)
        } else {
            return CGFloat(Float(self) / 2)
        }
    }
}
extension Float {
    var pixelToPoint: CGFloat {
        return CGFloat(self / 2)
    }
}


extension UIColor {
    class func globalBackGroundColor() -> UIColor {
        return UIColor.init(hexString: "#e9edf2", withAlpha: 1.0)
    }
    
    class func globalRedColor() -> UIColor {
        return UIColor.init(hexString: "#fe4462", withAlpha: 1.0)
    }
    
    class func globalDarkColor() -> UIColor {
        return UIColor.init(hexString: "#3d4756", withAlpha: 1.0)
    }
    
    class func globalLightGrayColor() -> UIColor {
        return UIColor.init(hexString: "#c1c3c7", withAlpha: 1.0)
    }
    
    class func globalSeparatorColor() -> UIColor {
        return UIColor.init(hexString: "#e3e3e3", withAlpha: 1.0)
    }
    

}




