//
//  OrderViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

enum OrderType: Int {
    case All = 0
    case NoFinished
    case WaitPayed
    case Payed
    case Closed
    case Delivering
    case Finished
}

class OrderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var items: [String]!
    var titleButton: UIButton!
    var titleView: UIView!
    
    var expanded: Bool = false
    
    var currentType: OrderType = .All
    
    var titleList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        items = ["全部订单","未完成","待付款","已关闭","待收货","已完成"]
        
        
        titleView = UIView.init(frame: CGRectMake(0, 0, 200, 40))
        self.navigationItem.titleView = titleView
        
        titleButton = UIButton.init(type: .Custom)
        titleButton.setTitle(items[currentType.rawValue], forState: .Normal)
        titleButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        titleButton.addTarget(self, action: #selector(self.searchType), forControlEvents: .TouchUpInside)
        titleView.addSubview(titleButton)
        
        titleButton.snp_makeConstraints { (make) in
            make.center.equalTo(titleView)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        
        titleList = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(titleList)
        titleList.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        titleList.delegate = self
        titleList.dataSource = self
        titleList.tableFooterView = UIView()
        
        titleList.registerClass(OrderTypeCell.self, forCellReuseIdentifier: "OrderTypeCell")
        
        searchType()
    }
    
    func searchType() {
        if expanded {
            titleList.snp_remakeConstraints { (make) in
                make.top.right.left.equalTo(view)
                make.height.equalTo(44 * items.count)
            }
        } else {
            titleList.snp_remakeConstraints { (make) in
                make.top.right.left.equalTo(view)
                make.height.equalTo(0)
            }
        }
        expanded = !expanded

    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === titleList {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView === titleList {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderTypeCell", forIndexPath: indexPath)
            cell.textLabel?.text = items[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView === titleList {
            self.currentType = OrderType(rawValue: indexPath.row)!
            titleButton.setTitle(items[currentType.rawValue], forState: .Normal)
            searchType()
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
