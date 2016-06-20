//
//  ThirdViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class ThirdViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{

    var bottomView: UIView!
    
    var tableView: UITableView!
    
    var items: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [""]

        // Do any additional setup after loading the view.
        bottomView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        
        bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(35)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }
        
        tableView = UITableView.init(frame: CGRectZero, style: .Plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.registerClass(ThirdGoodsCell.self, forCellReuseIdentifier: "ThirdGoodsCell")
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        tableView.tableFooterView = UIView()
        
        
        let totalView = UIView()
        view.addSubview(totalView)
        totalView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            make.height.equalTo(44)
        }
        
        let allChooseButton = UIButton.init(type: .Custom)
        allChooseButton.setImage(UIImage.init(named: "fourtag")!, forState: .Normal)
        
        totalView.addSubview(allChooseButton)
        
        allChooseButton.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(totalView)
            make.height.width.equalTo(20)
        }
        
        let allTitle = UILabel.init()
        totalView.addSubview(allTitle)
        allTitle.snp_makeConstraints { (make) in
            make.left.equalTo(allChooseButton.snp_right)
            make.centerY.equalTo(allChooseButton)
        }
        
        allTitle.text = "全选"
        allTitle.textColor = UIColor.lightGrayColor()
        allTitle.font = UIFont.systemFontOfSize(12.0)
        
        let jiesuanButton = UIButton()
        totalView.addSubview(jiesuanButton)
        jiesuanButton.snp_makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(totalView)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
        
        jiesuanButton.setTitle("结算", forState: .Normal)
        jiesuanButton.backgroundColor = UIColor.brownColor()
        jiesuanButton.addTarget(self, action: #selector(self.gotoPay), forControlEvents: .TouchUpInside)
        
        let priceLabel = UILabel()
        totalView.addSubview(priceLabel)
        priceLabel.textColor = UIColor.redColor()
        priceLabel.text = "￥100.00"
        priceLabel.font = UIFont.boldSystemFontOfSize(14.0)
        priceLabel.snp_makeConstraints { (make) in
            make.right.equalTo(jiesuanButton.snp_left).offset(-8)
            make.top.equalTo(jiesuanButton.snp_top)
        }
        
        let hejiLabel = UILabel()
        hejiLabel.text = "合计:"
        totalView.addSubview(hejiLabel)
        hejiLabel.textColor = UIColor.lightGrayColor()
        hejiLabel.font = UIFont.systemFontOfSize(12.0)
        hejiLabel.snp_makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp_left).offset(0)
            make.centerY.equalTo(priceLabel)
        }
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ThirdGoodsCell", forIndexPath: indexPath)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoPay() {
        let  payVC = PayViewController.init(nibName: "PayViewController", bundle: nil)
        payVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(payVC, animated: true)
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
