//
//  CollectionTableViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {

    var colletionList: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "我的收藏"
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.registerClass(CollectCell.self, forCellReuseIdentifier: "CollectCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.globalBackGroundColor()
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
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell

        // Configure the cell...

        return cell
    }
}


class CollectCell: UITableViewCell {
    
    var mainView: UIView!
    
    var goodImageView: UIImageView!
    var goodTitleLabel: UILabel!
    var priceLabel: UILabel!
    var deleteButton: UIButton!
    var deleteHandler: (Int -> Void)?
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fd5b59")])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length))
            priceLabel.attributedText = attributeString
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.backgroundColor = UIColor.clearColor()
        
        mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        self.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(20.pixelToPoint)
            make.right.equalTo(-20.pixelToPoint)
            make.top.equalTo(24.pixelToPoint)
            make.bottom.equalTo(self)
        }
        
        goodImageView = UIImageView()
        mainView.addSubview(goodImageView)
        goodImageView.snp_makeConstraints { (make) in
            make.left.equalTo(20.pixelToPoint)
            make.top.equalTo(24.pixelToPoint)
            make.width.height.equalTo(200.pixelToPoint)
        }
        
        goodTitleLabel = UILabel()
        goodTitleLabel.numberOfLines = 0
        goodTitleLabel.font = UIFont.systemFontOfSize(16.0)
        goodTitleLabel.textColor = UIColor.init(hexString: "#2f2f33")
        mainView.addSubview(goodTitleLabel)
        goodTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp_right).offset(20.pixelToPoint)
            make.top.equalTo(32.pixelToPoint)
            make.right.equalTo(-20.pixelToPoint)
        }
        
        
        priceLabel = UILabel()
        mainView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodTitleLabel)
            make.baseline.equalTo(goodImageView.snp_bottom).offset(-20.pixelToPoint)
        }
        
        deleteButton = UIButton.init(type: .Custom)
        deleteButton.setImage(UIImage.init(named: "collection_delete_0"), forState: .Normal)
        deleteButton.setImage(UIImage.init(named: "collection_delete_1"), forState: .Highlighted)

        mainView.addSubview(deleteButton)
        deleteButton.snp_makeConstraints { (make) in
            make.right.equalTo(-19.pixelToPoint)
            make.bottom.equalTo(-22.pixelToPoint)
            make.width.equalTo(144.pixelToPoint)
            make.height.equalTo(72.pixelToPoint)
        }
        
        deleteButton.addTarget(self, action: #selector(self.deleteCollect), forControlEvents: .TouchUpInside)
    }
    
    func deleteCollect() {
        self.deleteHandler?(self.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}