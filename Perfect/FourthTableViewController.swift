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

    let items = [["个人信息","修改密码","收货地址管理"],["查看订单","清除缓存"]]
    var header: UIView!
    var avatarImageView: UIImageView!
    var nickNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(MeCell.self, forCellReuseIdentifier: MeCell.identifier)
        
        header = UIView.init(frame: CGRectMake(0, 0, Tool.width, 525.pixelToPoint))
        
        let headerBgImageView = UIImageView()
        headerBgImageView.image = UIImage.init(named: "me_bg")
        header.addSubview(headerBgImageView)
        headerBgImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(header)
        }
       
        
        let circle = UIImageView()
        circle.image = UIImage.init(named: "me_circle")
        header.addSubview(circle)
        circle.snp_makeConstraints { (make) in
            make.width.height.equalTo(220.pixelToPoint)
            make.center.equalTo(header)
        }
        
        avatarImageView = UIImageView()
        avatarImageView.image = UIImage.init(named: "me_avatar")
        avatarImageView.userInteractionEnabled = true
        avatarImageView.layer.cornerRadius = 220.pixelToPoint / 2
        avatarImageView.layer.masksToBounds = true
        
        header.addSubview(avatarImageView)
        
        avatarImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(circle).inset(UIEdgeInsetsMake(2, 2, 2, 2))
        }
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.changeAvatar))
        avatarImageView.addGestureRecognizer(tap)
        nickNameLabel = UILabel()
        nickNameLabel.text = "超人"
        nickNameLabel.textColor = UIColor.whiteColor()
        nickNameLabel.font = UIFont.systemFontOfSize(18)
        header.addSubview(nickNameLabel)
        
        nickNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(avatarImageView)
            make.top.equalTo(circle.snp_bottom).offset(32.pixelToPoint)
        }

        
        self.tableView.tableHeaderView = header
        self.tableView.backgroundColor = UIColor.globalBackGroundColor()
        
        let logout = UIButton.init(type: .Custom)
        logout.backgroundColor = UIColor.clearColor()
        logout.setTitleColor(UIColor.init(hexString: "#b33333"), forState: .Normal)
        logout.addTarget(self, action: #selector(self.logout), forControlEvents: .TouchUpInside)
        logout.setTitle("退出登录", forState: .Normal)
        logout.frame = CGRectMake(0, 0, Tool.width, 129.pixelToPoint)
        self.tableView.tableFooterView = logout
    }
    
    
    func logout() {
        Util.logined = false
        let tab =  Tool.root.viewControllers.first as! RootTabBarController
        tab.selectedIndex = 0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return items.first!.count
        } else {
            return items.last!.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        
            let cell = tableView.dequeueReusableCellWithIdentifier(MeCell.identifier, forIndexPath: indexPath) as! MeCell
            cell.title.text = items[indexPath.section][indexPath.row]
            return cell
    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath == NSIndexPath.init(forRow: 0, inSection: 0) {
            let personal = PeronalViewController.someController(PeronalViewController.self, ofStoryBoard: UIStoryboard.main)
            personal.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(personal, animated: true)
        } else if indexPath == NSIndexPath.init(forRow: 1, inSection: 0) {
            let change = Tool.sb.instantiateViewControllerWithIdentifier("ChangePasswordViewController") as! ChangePasswordViewController
            change.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(change, animated: true)
        } else if indexPath == NSIndexPath.init(forRow: 2, inSection: 0) {
            let addressVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddressViewController") as! AddressViewController
            addressVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addressVC, animated: true)
        } else if indexPath == NSIndexPath.init(forRow: 0, inSection: 1) {
            let orderVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AllOrderViewController") as! AllOrderViewController
            orderVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(orderVC, animated: true)
        } else if indexPath == NSIndexPath.init(forRow: 1, inSection: 1) {
                //提示清楚缓存
                SVProgressHUD.showWithStatus("正在清除缓存")
                Async.main(after: 1.0, block: {
                    SVProgressHUD.showSuccessWithStatus("清除成功")
                })
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 22.pixelToPoint : 0.01
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.pixelToPoint
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    func profile() {
        let profileVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PeronalViewController") as! PeronalViewController
        profileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    
    func changeAvatar() {
        
        let avatarVC = AvatarViewController.someController(AvatarViewController.self, ofStoryBoard: UIStoryboard.main)
        avatarVC.modalPresentationStyle = .OverCurrentContext
        avatarVC.view.backgroundColor = UIColor.clearColor()
        self.presentViewController(avatarVC, animated: false, completion: nil)
    }
    
    
}

class MeCell: UITableViewCell {
    static let identifier = "MeCell"
    
    var title: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel.init()
        title.textColor = UIColor.init(hexString: "#333333")
        title.font = UIFont.systemFontOfSize(14.0)
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(24.pixelToPoint)
            make.centerY.equalTo(self)
        }
        self.accessoryType = .DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

