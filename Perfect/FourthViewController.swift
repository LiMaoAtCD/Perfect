//
//  FourthViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class MeNavigationController: UINavigationController {
    
}

class FourthViewController: BaseViewController {

    var fourthTableViewController : FourthTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        self.fd_prefersNavigationBarHidden = true
        edgesForExtendedLayout = UIRectEdge.None

        fourthTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FourthTableViewController") as! FourthTableViewController
        self.addChildViewController(fourthTableViewController)
        view.addSubview(fourthTableViewController.view)
        fourthTableViewController.view.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        if !Util.logined {
            let nav = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginNavigationController") as! UINavigationController
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        NetworkHelper.instance.request(.GET, url: URLConstant.appMemberCenterIndex.contant, parameters: ["rows": 0, "page": 1], completion: { [weak self](res: PersonalCenterResponse?) in
                let personalEntity = res?.retObj
            
            
                self?.fourthTableViewController.avatarImageView.image =  UIImage.init(named: "me_avatar")
            
                self?.fourthTableViewController.nickNameLabel.text = personalEntity?.memberInfo?.nick
            }) { (errMsg: String?, errCode: Int) in
                
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
