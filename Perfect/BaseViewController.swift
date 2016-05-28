//
//  BaseViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

extension UIViewController {
    func configurePopNavigationItem() {
        let image = UIImage(named: "ic_back")
        let backButton = UIButton(type: .Custom)
        backButton.setImage(image, forState: .Normal)
        backButton.frame = CGRectMake(0, 0, image!.size.width, image!.size.height)
        backButton.addTarget(self, action: #selector(UIViewController.pop), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func pop() {
        if self.navigationController?.viewControllers.count > 1 {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}

struct Tools {
    static let width = UIScreen.mainScreen().bounds.size.width
    static let height = UIScreen.mainScreen().bounds.size.height

}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
