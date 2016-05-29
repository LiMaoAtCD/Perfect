//
//  ThirdViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var bottomView: UIView!
    
    var tableView: UITableView!
    
    var items: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [""]

        // Do any additional setup after loading the view.
        bottomView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        
        bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(35)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }
        
        tableView = UITableView.init(frame: CGRectZero, style: .Plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        tableView.tableFooterView = UIView()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
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
