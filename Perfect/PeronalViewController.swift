//
//  PeronalViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class PeronalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let upperView = UIView()
        view.addSubview(upperView)
        upperView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(150)
        }
        
        let avatarImageView = UIImageView()
        upperView.addSubview(avatarImageView)
        avatarImageView.snp_makeConstraints { (make) in
            make.center.equalTo(upperView)
            make.height.width.equalTo(100)
        }
        
        let centerView = UIView()
        view.addSubview(centerView)
        centerView.snp_makeConstraints { (make) in
            make.top.equalTo(upperView.snp_bottom).offset(20)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
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
