//
//  PeronalViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class PeronalViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        items = ["姓名","性别","生日","手机号"]

        
        let tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
            
        }
        tableView.registerClass(PersonalCell.self, forCellReuseIdentifier: "Personal")
        tableView.scrollEnabled = false
        
        
        let upperView = UIView.init(frame: CGRectMake(0, 0, Tool.width, 150))
        
        let avatarImageView = UIImageView()
        upperView.addSubview(avatarImageView)
        avatarImageView.image = UIImage.init(named: "fourtag")
        avatarImageView.snp_makeConstraints { (make) in
            make.center.equalTo(upperView)
            make.height.width.equalTo(100)
        }
        tableView.tableHeaderView = upperView
        
        
        
        let footerView = UIView.init(frame: CGRectMake(0, 0, Tool.width, 50))
        
        let saveButton = UIButton.init(type: .Custom)
        saveButton.addTarget(self, action: #selector(self.save), forControlEvents: .TouchUpInside)
        saveButton.setTitle("保存", forState: .Normal)
        saveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        saveButton.backgroundColor = UIColor.brownColor()
        saveButton.layer.cornerRadius = 3.0
        saveButton.layer.masksToBounds = true
        footerView.addSubview(saveButton)
        saveButton.snp_makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.center.equalTo(footerView)
        }
        
        tableView.tableFooterView = footerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Personal", forIndexPath: indexPath) as! PersonalCell
        cell.title.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func save() {
        
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
