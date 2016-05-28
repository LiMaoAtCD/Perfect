//
//  FirstViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var tableViewController: FirstTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewController = FirstTableViewController.viewController()
        self.addChildViewController(tableViewController)
        view.addSubview(tableViewController.view)
        tableViewController.view.frame = view.bounds
        
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

}
