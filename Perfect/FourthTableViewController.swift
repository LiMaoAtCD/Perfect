//
//  FourthTableViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit



class FourthTableViewController: UITableViewController {

    var items:[String]?
    
    var header: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        items = ["全部订单", "收货地址","联系客服","设置"]

        self.tableView.registerClass(FourthTableViewCell.self, forCellReuseIdentifier: FourthTableViewCell.identifier)
        self.tableView.tableFooterView = UIView()
        
        
        header = UIView.init(frame: CGRectMake(0, 0, Tools.width, 200))
        header.backgroundColor = UIColor.brownColor()
        
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage.init(named: "fourtag")
        avatarImageView.userInteractionEnabled = true
        header.addSubview(avatarImageView)
        
        avatarImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(20)
            make.centerX.equalTo(header)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.profile))
        avatarImageView.addGestureRecognizer(tap)
        let nickNameLabel = UILabel()
        nickNameLabel.text = "超人"
        nickNameLabel.textColor = UIColor.blackColor()
        header.addSubview(nickNameLabel)
        
        nickNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(avatarImageView)
            make.top.equalTo(avatarImageView.snp_bottom).offset(10)
        }
        
        let bottomBackGroundView = UIView()
        header.addSubview(bottomBackGroundView)
        bottomBackGroundView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(header)
            make.height.equalTo(35)
        }
        bottomBackGroundView.backgroundColor = UIColor.whiteColor()
        
        let needPaybutton = UIButton.init(type: .Custom)
        
        let needDeliverButton = UIButton.init(type: .Custom)

        bottomBackGroundView.addSubview(needPaybutton)
        bottomBackGroundView.addSubview(needDeliverButton)

        needPaybutton.snp_makeConstraints { (make) in
            make.left.height.top.equalTo(bottomBackGroundView)
            make.right.equalTo(bottomBackGroundView.snp_centerX)
        }
        
        needDeliverButton.snp_makeConstraints { (make) in
            make.right.height.top.equalTo(bottomBackGroundView)
            make.left.equalTo(bottomBackGroundView.snp_centerX)
        }

        needPaybutton.setTitle("待支付", forState: .Normal)
        needPaybutton.setTitleColor(UIColor.blackColor(), forState: .Normal)

        needDeliverButton.setTitle("待收货", forState: .Normal)
        needDeliverButton.setTitleColor(UIColor.blackColor(), forState: .Normal)

        
        
        needPaybutton.addTarget(self, action: #selector(self.needPay), forControlEvents: .TouchUpInside)
        needDeliverButton.addTarget(self, action: #selector(self.needDeliver), forControlEvents: .TouchUpInside)
        
        self.tableView.tableHeaderView = header
    }
    
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
        return items!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FourthTableViewCell.identifier, forIndexPath: indexPath) as! FourthTableViewCell

        // Configure the cell...
        
        cell.tagImageView.image = UIImage.init(named: "fourtag")
        cell.title.text = items![indexPath.row]
        

        return cell
    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.showAllOrder()
        } else if indexPath.row == 1 {
            let addressVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddressViewController") as! AddressViewController
            addressVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addressVC, animated: true)
        } else if indexPath.row == 2 {
            let fellbackVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FellbackViewController") as! FellbackViewController
            fellbackVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(fellbackVC, animated: true)
        } else if indexPath.row == 3 {
            let settingVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SettingViewController") as! SettingViewController
            settingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(settingVC, animated: true)
        } else {
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
