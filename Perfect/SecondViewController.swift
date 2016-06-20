//
//  SecondViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    var secondTableViewController: SecondTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        
        secondTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondTableViewController") as! SecondTableViewController
        
        self.addChildViewController(secondTableViewController)
        
        self.view.addSubview(secondTableViewController.view)
        secondTableViewController.view.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
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
