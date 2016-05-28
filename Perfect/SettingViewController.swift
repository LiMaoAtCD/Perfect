//
//  SettingViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    var items: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(SettingNormalCell.self, forCellReuseIdentifier: "Normal")
        tableView.registerClass(SettingPushCell.self, forCellReuseIdentifier: "Push")

        
        items = ["通知推送","清除缓存","关于我们"]
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Push", forIndexPath: indexPath) as! SettingPushCell
            cell.tagImageView.image = UIImage.init(named: "fourtag")
            cell.title.text = items![indexPath.row]
            cell.switcher.on = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Normal", forIndexPath: indexPath) as! SettingNormalCell
            cell.tagImageView.image = UIImage.init(named: "fourtag")
            cell.title.text = items![indexPath.row]
            return cell
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
