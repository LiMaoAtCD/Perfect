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
            make.left.right.top.equalTo(scrollView)
            make.height.equalTo(300)
        }
        
        goodsDetailView = UIView.init()
        scrollView.addSubview(goodsDetailView)
        
        
        
        

        
        
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
