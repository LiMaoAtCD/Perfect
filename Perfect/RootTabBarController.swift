//
//  RootTabBarController.swift
//  Perfect
//
//  Created by limao on 16/6/16.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class RootTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if viewController is MeNavigationController && !Util.logined {
            
            Defaults[.shouldSwitch] = true
            let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginNavigationController") as! LoginNavigationController
            self.presentViewController(login, animated: true, completion: nil)
            return false
        }
        return true

    }

}


