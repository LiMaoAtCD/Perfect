//
//  FourthTableViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
import Async


class FourthTableViewController: UITableViewController {

    let items = ["个人信息","修改密码", "设置手势密码","收货地址管理","清除缓存","我的订单","退出登录"]
    var header: UIView!
    
    var avatarImageView: UIImageView!
    var nickNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(MeCell.self, forCellReuseIdentifier: MeCell.identifier)
        self.tableView.registerClass(LogOutCell.self, forCellReuseIdentifier: LogOutCell.identifier)
        self.tableView.tableFooterView = UIView()
        
        
        header = UIView.init(frame: CGRectMake(0, 0, Tool.width, 300))
        header.backgroundColor = UIColor.brownColor()
        
        let headerBgImageView = UIImageView()
        headerBgImageView.image = UIImage.init(named: "fourtag")
        header.addSubview(headerBgImageView)
        headerBgImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(header)
        }
        
        avatarImageView = UIImageView()
        avatarImageView.image = UIImage.init(named: "fourtag")
        avatarImageView.userInteractionEnabled = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.masksToBounds = true
        
        header.addSubview(avatarImageView)
        
        avatarImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(header)
        }
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.profile))
        avatarImageView.addGestureRecognizer(tap)
        nickNameLabel = UILabel()
        nickNameLabel.text = "超人"
        nickNameLabel.textColor = UIColor.blackColor()
        header.addSubview(nickNameLabel)
        
        nickNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(avatarImageView)
            make.top.equalTo(avatarImageView.snp_bottom).offset(10)
        }
        
//        let bottomBackGroundView = UIView()
//        header.addSubview(bottomBackGroundView)
//        bottomBackGroundView.snp_makeConstraints { (make) in
//            make.left.right.bottom.equalTo(header)
//            make.height.equalTo(35)
//        }
//        
//        bottomBackGroundView.backgroundColor = UIColor.whiteColor()
//        
//        let needPaybutton = UIButton.init(type: .Custom)
//        
//        let needDeliverButton = UIButton.init(type: .Custom)
//
//        bottomBackGroundView.addSubview(needPaybutton)
//        bottomBackGroundView.addSubview(needDeliverButton)
//
//        needPaybutton.snp_makeConstraints { (make) in
//            make.left.height.top.equalTo(bottomBackGroundView)
//            make.right.equalTo(bottomBackGroundView.snp_centerX)
//        }
//        
//        needDeliverButton.snp_makeConstraints { (make) in
//            make.right.height.top.equalTo(bottomBackGroundView)
//            make.left.equalTo(bottomBackGroundView.snp_centerX)
//        }
//
//        needPaybutton.setTitle("待支付", forState: .Normal)
//        needPaybutton.setTitleColor(UIColor.blackColor(), forState: .Normal)
//
//        needDeliverButton.setTitle("待收货", forState: .Normal)
//        needDeliverButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
//
//        
//        
//        needPaybutton.addTarget(self, action: #selector(self.needPay), forControlEvents: .TouchUpInside)
//        needDeliverButton.addTarget(self, action: #selector(self.needDeliver), forControlEvents: .TouchUpInside)
        
        self.tableView.tableHeaderView = header
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        
        if indexPath != NSIndexPath.init(forRow: 5, inSection: 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier(MeCell.identifier, forIndexPath: indexPath) as! MeCell
            cell.title.text = items[indexPath.row]

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(LogOutCell.identifier, forIndexPath: indexPath) as! LogOutCell

            return cell
        }
        

    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let personal = UIViewController
            
        } else if indexPath.row == 1 {
            
            let change = Tool.sb.instantiateViewControllerWithIdentifier("ChangePasswordViewController") as! ChangePasswordViewController
            change.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(change, animated: true)

            let gesture = Tool.sb.instantiateViewControllerWithIdentifier("GesturePasswordViewController") as! GesturePasswordViewController
            gesture.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(gesture, animated: true)
        } else if indexPath.row == 2 {
            
            let addressVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddressViewController") as! AddressViewController
            addressVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addressVC, animated: true)
        } else if indexPath.row == 3 {
            //提示清楚缓存
            SVProgressHUD.showWithStatus("正在清除缓存")
            Async.main(after: 1.0, block: { 
                SVProgressHUD.showSuccessWithStatus("清除成功")
            })
        } else if indexPath.row == 4 {
            let orderVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AllOrderViewController") as! AllOrderViewController
            orderVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(orderVC, animated: true)
        } else {
            Util.logined = false
            let tab =  Tool.root.viewControllers.first as! RootTabBarController
            tab.selectedIndex = 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    //MARK: 事件
    
    func needPay() {
        self.goToOrder(.WaitPayed)
    }
    
    func needDeliver() {
        self.goToOrder(.Delivering)
        
    }
    
    func showAllOrder() {
        self.goToOrder(.All)
    }
    
    func goToOrder(type: OrderType) {
        
        let orderVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("OrderViewController") as! OrderViewController
        
        orderVC.hidesBottomBarWhenPushed = true
        
        orderVC.currentType = type
        
        
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    func profile() {
        let profileVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PeronalViewController") as! PeronalViewController
        profileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    
    
}

class MeCell: UITableViewCell {
    static let identifier = "MeCell"
    
    var title: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel.init()
        
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(14)
            make.centerY.equalTo(self)
        }
        self.accessoryType = .DisclosureIndicator
        self.selectionStyle = .None

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class LogOutCell: UITableViewCell {
    static let identifier = "LogoutCell"
    
    var title: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel.init()
        
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        title.textColor = UIColor.redColor()
        title.text = "退出登录"

        self.accessoryType = .None
        self.selectionStyle = .None
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
