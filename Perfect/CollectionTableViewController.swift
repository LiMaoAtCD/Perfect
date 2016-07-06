//
//  CollectionTableViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD

class CollectionTableViewController: UITableViewController {

    var colletionList: [CollectProductItem]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageFromColor(UIColor.whiteColor()), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init(named: "navi_shadow")
        self.navigationController?.navigationBar.translucent = false

        
        colletionList = [CollectProductItem]()
        self.title = "我的收藏"
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.registerClass(CollectCell.self, forCellReuseIdentifier: "CollectCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.globalBackGroundColor()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NetworkHelper.instance.request(.GET, url: URLConstant.getLoginMemberFavoriteGoodsList.contant, parameters: ["rows": 15,"page": 1], completion: { [weak self](result: CollectProductResponse?) in
            self?.colletionList = result?.retObj?.rows
            self?.tableView.reloadData()
        }) { (msg, code) in
            SVProgressHUD.showErrorWithStatus(msg)
        }

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
        return colletionList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell

        // Configure the cell...
        cell.entity = colletionList[indexPath.row]
        cell.deleteHandler = {
            [weak self] tag in
            self?.deleteCollectItem(self!.colletionList[indexPath.row].id)
        }

        return cell
    }
    
    func deleteCollectItem(ID: Int64) {
        NetworkHelper.instance.request(.GET, url: URLConstant.setLoginMemberGoodsFavorite.contant, parameters: ["goodsId":NSNumber.init(longLong: ID), "isFavorite": "false"], completion: { (result: DataResponse?) in
                self.colletionList = self.colletionList.filter({ (item) -> Bool in
                    return item.id != ID
                })
                self.tableView.reloadData()
            }) { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let detail = GoodsDetailViewController.someController(GoodsDetailViewController.self, ofStoryBoard: UIStoryboard.main)
        detail.id = self.colletionList![indexPath.row].id
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
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
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            priceLabel.attributedText = attributeString
        }
        
    }
    
    var entity: CollectProductItem? {
        willSet {
            if let _ = newValue {
                self.price = newValue!.price
                self.goodTitleLabel.text = newValue!.name
                self.goodImageView.kf_setImageWithURL(NSURL.init(string: newValue!.thumbnailId.perfectImageurl(200, h: 200, crop: true))!)
            }
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
            make.bottom.equalTo(-25.pixelToPoint)

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