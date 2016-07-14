//
//  AppDelegate.swift
//  Perfect
//
//  Created by limao on 16/5/25.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SVProgressHUD
import RealmSwift
import Async
import SwiftyUserDefaults


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configureRealm()

        configureSVProgressHUD()
        
        hello()
        fetchAreaID()
        configureReachability()

        UINavigationBar.appearance().barTintColor = UIColor.globalRedColor()
        

    
        return true
    }
    
    func configureSVProgressHUD() {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)

    }
    
    func configureReachability() {
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
            if status == .NotReachable || status == .Unknown {
                SVProgressHUD.showErrorWithStatus("网络已经断开，请检查网络设置")
            } else {
            
            }
        }
        
        manager?.startListening()
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func fetchAreaID(){
        
        let version = NSUserDefaults.standardUserDefaults().objectForKey("AddressAreaVersion") as? NSNumber
        NetworkHelper.instance.request(.GET, url: URLConstant.getAreasTreeJson.contant, parameters: ["areaTreeVer": version ?? 0], completion: { (result: AreaTreeResponse?) in
            
                NSUserDefaults.standardUserDefaults().setObject(NSNumber.init(longLong: result!.retObj!.areaTreeVer), forKey: "AddressAreaVersion")
                if let data = result?.retObj {
                    let realm = try! Realm()
                    try! realm.write({ realm.add(data, update: true) })
                }
            
        }) { (msg: String?, code: Int) in
        }
    }

    func configureRealm() {
        let config = Realm.Configuration(
            // 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
            schemaVersion: 2,
            
            // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
            migrationBlock: { migration, oldSchemaVersion in
                // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
                }
        })
        
        // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
        Realm.Configuration.defaultConfiguration = config
        
        // 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
        _ = try! Realm()
    }
    
    func hello() {
        NetworkHelper.instance.request(.GET, url: URLConstant.hello.contant, parameters: nil, completion: nil, failed: nil)
    }
}


extension AppDelegate {
    class func login() {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let _ = delegate {
            if let window = delegate!.window {
                if let vc = window.rootViewController {
                    let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginNavigationController") as! LoginNavigationController
                    vc.presentViewController(login, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (resultDic: [NSObject : AnyObject]!) in
                
            })
        }
        
        if url.host == "platformapi" {
        
        }
        
        return true
//        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
//        if ([url.host isEqualToString:@"safepay"]) {
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
//                NSLog(@"result = %@",resultDic);
//                }];
//        }
//        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
//            
//            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
//                NSLog(@"result = %@",resultDic);
//                }];
//        }
//        return YES;
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (resultDic: [NSObject : AnyObject]!) in
                
            })
        }
        
        if url.host == "platformapi" {
            
        }
        
        return true
    }

}

