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
        items = ["姓名","性别","生日"]

        
        let tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
            
        }
        tableView.registerClass(PersonalCell.self, forCellReuseIdentifier: "Personal")
        tableView.scrollEnabled = false
        
        
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
}

class PersonalCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var title: UILabel!
    var detail: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title = UILabel()
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.centerY.equalTo(self)
        }
        
        detail = UILabel()
        self.addSubview(detail)
        detail.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-8)
            make.centerY.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
