//
//  GoodsDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/15.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView

class GoodsDetailViewController: UIViewController {
    var scrollView: UIScrollView!

    var topBanner: SDCycleScrollView!
    var goodsDetailView: UIView!
    var goodDetailLabel: UILabel!
    var goodImageViews: [UIImageView]!
    var customSteps: UILabel!
    var helperView: UIView!
    var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView.init()
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        topBanner = SDCycleScrollView.init()
        topBanner.placeholderImage = UIImage.init(named: "placeholder")!
        topBanner.clickItemOperationBlock = { index in
        
        }
        
        topBanner.imageURLStringsGroup = [String]()
        scrollView.addSubview(topBanner)
        
        topBanner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        topBanner.currentPageDotColor = UIColor.whiteColor()
        
        topBanner.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(300)
        }
        
        configureGoodInfoView()
        
        
    }
    
    func configureGoodInfoView() {
        goodsDetailView = UIView.init()
        scrollView.addSubview(goodsDetailView)
        
        goodsDetailView.snp_makeConstraints { (make) in
            make.top.equalTo(topBanner.snp_bottom)
            make.left.right.equalTo(topBanner)
            make.height.equalTo(300)
        }
        
        let titleLabel = UILabel()
        goodsDetailView.addSubview(titleLabel)
        titleLabel.text = "ABC大连会计电费卡拉克剪短发开发及地方了发垃圾费卡里就发啦空间发的卡"
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.numberOfLines = 0
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsDetailView).offset(10)
            make.right.equalTo(goodsDetailView).offset(-10)
            make.top.equalTo(10)
        }
        
        let priceLabel: UILabel! = UILabel()
        
        goodsDetailView.addSubview(priceLabel)
        priceLabel.text = "1200"
        priceLabel.font = UIFont.systemFontOfSize(20)
        priceLabel.textColor = UIColor.redColor()
        
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsDetailView).offset(10)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
        }
        
        
        
        let marketPriceLabel: UILabel!  = UILabel()
        
        goodsDetailView.addSubview(marketPriceLabel)
        marketPriceLabel.text = "1200"
        marketPriceLabel.font = UIFont.systemFontOfSize(13)
        marketPriceLabel.textColor = UIColor.lightGrayColor()
        
        marketPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(priceLabel.snp_right).offset(10)
            make.centerY.equalTo(priceLabel)
        }
        
        let homeTag = UIImageView()
        goodsDetailView.addSubview(homeTag)
        homeTag.image = UIImage.init(named: "perfect")
        homeTag.snp_makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.left.equalTo(titleLabel)
            make.top.equalTo(marketPriceLabel.snp_bottom).offset(10)
        }
        
        let companyLabel: UILabel!  = UILabel()
        
        goodsDetailView.addSubview(companyLabel)
        companyLabel.text = "美国圣地亚哥金坷垃公司"
        companyLabel.font = UIFont.systemFontOfSize(13)
        companyLabel.textColor = UIColor.lightGrayColor()
        
        companyLabel.snp_makeConstraints { (make) in
            make.left.equalTo(homeTag.snp_right).offset(10)
            make.centerY.equalTo(homeTag)
        }
        
        let deliverTag = UIImageView()
        goodsDetailView.addSubview(deliverTag)
        deliverTag.image = UIImage.init(named: "perfect")
        deliverTag.snp_makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.left.equalTo(homeTag)
            make.top.equalTo(homeTag.snp_bottom).offset(10)
        }
        
        let deliverLabel: UILabel!  = UILabel()
        
        goodsDetailView.addSubview(deliverLabel)
        deliverLabel.text = "24adadfjakkdjfhadfjkahdfkjahdfkjahdfjkadfhkjfhd"
        deliverLabel.font = UIFont.systemFontOfSize(13)
        deliverLabel.textColor = UIColor.lightGrayColor()
        
        deliverLabel.snp_makeConstraints { (make) in
            make.left.equalTo(deliverTag.snp_right).offset(10)
            make.centerY.equalTo(deliverTag)
        }
        
        let unknownTag = UIImageView()
        goodsDetailView.addSubview(unknownTag)
        unknownTag.image = UIImage.init(named: "perfect")
        unknownTag.snp_makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.left.equalTo(homeTag)
            make.top.equalTo(deliverTag.snp_bottom).offset(10)
        }
        
        let unknownLabel: UILabel!  = UILabel()
        
        goodsDetailView.addSubview(unknownLabel)
        unknownLabel.text = "24adadfjakkdjfhadfjkahdfkjahdfkjahdfjkadfhkjfhd"
        unknownLabel.font = UIFont.systemFontOfSize(13)
        unknownLabel.textColor = UIColor.lightGrayColor()
        
        unknownLabel.snp_makeConstraints { (make) in
            make.left.equalTo(unknownTag.snp_right).offset(10)
            make.centerY.equalTo(unknownTag)
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

class GoodDetailView: UIView {
    
    var title: UILabel!
    var priceLabel: UILabel!
    var marketPriceLabel: UILabel!
    
    var companyLabel: UILabel!
    var deliveryLabel: UILabel!
    var unknownLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
