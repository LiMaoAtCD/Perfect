//
//  FirstGoodsDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/29.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class FirstGoodsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var compositionButton: UIButton!
    var bottleButton: UIButton!
    var boxButton: UIButton!
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        tableView = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        let header = UIView.init(frame: CGRectMake(0, 0, Tools.width, 300))
        tableView.tableHeaderView = header
        
        
        
        compositionButton = UIButton()
        compositionButton.setTitle("组合", forState: .Normal)
        compositionButton.backgroundColor = UIColor.brownColor()
        header.addSubview(compositionButton)
        
        bottleButton = UIButton()
        bottleButton.setTitle("酒瓶", forState: .Normal)
        bottleButton.backgroundColor = UIColor.brownColor()

        header.addSubview(bottleButton)
        
        boxButton = UIButton()
        boxButton.setTitle("酒盒", forState: .Normal)
        boxButton.backgroundColor = UIColor.brownColor()
        header.addSubview(boxButton)
        
        compositionButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(view.snp_top).offset(50)
            make.centerX.equalTo(view.snp_centerX).multipliedBy(0.5)
        }
        
        bottleButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(view.snp_top).offset(50)
            make.centerX.equalTo(view.snp_centerX).multipliedBy(1)
        }
        
        boxButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(view.snp_top).offset(50)
            make.centerX.equalTo(view.snp_centerX).multipliedBy(1.5)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
