//
//  AddressViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    var tableView: UITableView!
    var address: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        address = [""]
        tableView = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "address")
        
        let header = UIView.init(frame: CGRectMake(0, 0, Tool.width, 50))
        tableView.tableHeaderView = header
        
        let addAddressButon = UIButton.init(type: .Custom)
        addAddressButon.setTitle("添加新地址", forState: .Normal)
        addAddressButon.backgroundColor = UIColor.brownColor()
        addAddressButon.setTitleColor(UIColor.blackColor(), forState: .Normal)
        header.addSubview(addAddressButon)
        
        addAddressButon.addTarget(self, action: #selector(self.addAddress), forControlEvents: .TouchUpInside)
        addAddressButon.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(40)
            make.center.equalTo(header)
        }
        
    }
    
    func addAddress() {
        let addressAdd = AddressAddViewController.init(nibName: "AddressAddViewController", bundle: nil)
        self.navigationController?.pushViewController(addressAdd, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("address", forIndexPath: indexPath) as! AddressTableViewCell
        
        
        return cell
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
