//
//  PeronalViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
class PeronalViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        type	用户类别	string	false	个人:person,单位:company
//        name	姓名	string	false
//        gender	性别	string	false	男:male,女:female
//        birth	生日	date	false
//        avatarId	头像ID	int	false
        

        NetworkHelper.instance.request(.GET, url: URLConstant.getLoginMemberInfo.contant, parameters: nil, completion: { (result: MemberInfoResponse?) in
            
        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg ?? "个人信息获取失败")
        }
        
        items = ["姓名","性别","生日","用户类别"]

        
        let tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.globalBackGroundColor()
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
    
    var title: UILabel!
    var detail: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title = UILabel()
        detail.font = UIFont.systemFontOfSize(14.0)
        detail.textColor = UIColor.init(hexString: "#333333")
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.centerY.equalTo(self)
        }
        
        detail = UILabel()
        detail.textAlignment = .Right
        detail.font = UIFont.systemFontOfSize(14.0)
        detail.textColor = UIColor.init(hexString: "#666666")
        self.addSubview(detail)
        detail.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-8)
            make.centerY.equalTo(self)
            make.left.equalTo(title.snp_right).offset(20)
            make.width.greaterThanOrEqualTo(150)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
