//
//  FirstViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ChameleonFramework

class FirstViewController: UIViewController {

    var leftTableViewController: FirstTableViewController!
    var rightTableViewController: FirstTableViewController!

    var topSelectionView: UIView!
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var leftImageUrls: [String]?
    var rightImageUrls: [String]?
    
    var leftItems:[String]?
    var rightItems: [String]?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "title"), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        
        topSelectionView = UIView()
        view.addSubview(topSelectionView)
        topSelectionView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
        
        leftButton = UIButton.init(type: .Custom)
        topSelectionView.addSubview(leftButton)
        
        leftButton.setTitle("定制", forState: .Normal)
        leftButton.tag = 0
        leftButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        leftButton.addTarget(self, action: #selector(self.changeList), forControlEvents: .TouchUpInside)
        leftButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(topSelectionView)
            make.right.equalTo(topSelectionView.snp_centerX)
        }
        rightButton = UIButton.init(type: .Custom)
        topSelectionView.addSubview(rightButton)
        rightButton.setTitle("商城", forState: .Normal)
        rightButton.tag = 1
        rightButton.addTarget(self, action: #selector(self.changeList), forControlEvents: .TouchUpInside)

        rightButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)

        rightButton.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(topSelectionView)
            make.left.equalTo(topSelectionView.snp_centerX)
        }
        
        
        leftTableViewController = FirstTableViewController.viewController()
        self.addChildViewController(leftTableViewController)
        view.addSubview(leftTableViewController.view)
        leftTableViewController.view.snp_makeConstraints { (make) in
            make.top.equalTo(topSelectionView.snp_bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }

        rightTableViewController = FirstTableViewController.viewController()
        self.addChildViewController(rightTableViewController)
        view.addSubview(rightTableViewController.view)
        rightTableViewController.view.snp_makeConstraints { (make) in
            make.top.equalTo(topSelectionView.snp_bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }
        rightTableViewController.view.hidden = true
      

        leftImageUrls = [
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
        ]
        
        rightImageUrls = [
            "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
            "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
            "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
             "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
        ]
        
        
        
        leftTableViewController.imageURLs = leftImageUrls
        rightTableViewController.imageURLs = rightImageUrls
        
        leftTableViewController.itemImageURLs = leftImageUrls
        rightTableViewController.itemImageURLs = rightImageUrls
    }
    
    func changeList(btn: UIButton) {
        if btn.tag == 0 {
            //
            leftButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            rightButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    
            rightTableViewController.view.hidden = true
            leftTableViewController.view.hidden = false
            
        } else {
            leftButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            rightButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            
            rightTableViewController.view.hidden = false
            leftTableViewController.view.hidden = true
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
