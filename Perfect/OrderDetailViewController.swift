//
//  OrderDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/26.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    
    var scrollView: UIScrollView!
    var bottomView: UIView!
    
    var mainView: UIView!
    var priceView: UIView!
    var packageImageView: UIImageView!
    //    var deliverTypeLabel: UILabel!
    //    var deliverNumberTitleLabel: UILabel!
    //    var deliverNumberLabel: UILabel!
    
    var topLabel: UILabel!
    
    var deliverMarginView: UIView!
    var addressTagImageView: UIImageView!
    var nameTitleLabel: UILabel!
    var nameLabel: UILabel!
    var cellphoneLabel: UILabel!
    var addressTitleLabel: UILabel!
    var addressLabel: UILabel!
    var addressMarginView: UIView!
    var goodsImageView: UIImageView!
    var goodTitleLabel: UILabel!
    var priceLabel: UILabel!
    var quantityLabel: UILabel!
    var goodMariginView: UIView!
    
    var customImageView: UIImageView!
    var customTitleLabel: UILabel!
    var moduleTitleLabel: UILabel!
    var moduleLabel: UILabel!
    var orderNumberTitleLabel: UILabel!
    var orderNumberLabel: UILabel!
    var orderTimeTitleLabel: UILabel!
    var orderTimeLabel: UILabel!
    var payTimeTitleLabel: UILabel!
    var payTimeLabel: UILabel!
    
    
    var priceTotalLabel: UILabel!
    
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fd5b59")])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length - 1))
            priceLabel.attributedText = attributeString
        }
    }
    
    var totalPrice: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fd5b59")])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length - 1))
            priceTotalLabel.attributedText = attributeString
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-50)
        }
        
        setupScrollSubViews()
        
        
        bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(50)
        }
        
        
    }

    func setupScrollSubViews() {
        mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        
        scrollView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(21.pixelToPoint)
            make.right.equalTo(view).offset(-21.pixelToPoint)
            make.top.equalTo(scrollView).offset(25.pixelToPoint)
        }
        //快递区域
        packageImageView = UIImageView()
        mainView.addSubview(packageImageView)
        packageImageView.snp_makeConstraints { (make) in
            make.left.equalTo(mainView).offset(20.pixelToPoint)
            make.width.height.equalTo(30.pixelToPoint)
            make.top.equalTo(30.pixelToPoint)
        }
        packageImageView.image = UIImage.init(named: "order_package")
        
        
        topLabel = UILabel()
        mainView.addSubview(topLabel)
        topLabel.font = UIFont.systemFontOfSize(13)
        topLabel.text = "圆通快递"
        topLabel.textColor = UIColor.init(hexString: "#2fb76c")
        
        topLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(packageImageView)
            make.left.equalTo(packageImageView.snp_right).offset(27.pixelToPoint)
            make.right.equalTo(-8)
        }
        
        
        deliverMarginView = UIView()
        deliverMarginView.backgroundColor = UIColor.init(hexString: "#ebebeb")
        mainView.addSubview(deliverMarginView)
        deliverMarginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.height.equalTo(1.pixelToPoint)
            make.top.equalTo(mainView).offset(78.pixelToPoint)
        }
        
        //地址区域
        addressTagImageView = UIImageView()
        mainView.addSubview(addressTagImageView)
        addressTagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(packageImageView)
            make.width.height.equalTo(30.pixelToPoint)
            make.top.equalTo(deliverMarginView).offset(40.pixelToPoint)
        }
        addressTagImageView.image = UIImage.init(named: "order_address")
        
        nameTitleLabel = UILabel()
        mainView.addSubview(nameTitleLabel)
        
        nameTitleLabel.text = "收货人:"
        nameTitleLabel.font = UIFont.systemFontOfSize(13)
        nameTitleLabel.textColor = UIColor.init(hexString: "#333333")
        
        nameTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(addressTagImageView.snp_right).offset(27.pixelToPoint)
            make.top.equalTo(deliverMarginView).offset(23.pixelToPoint)
        }
        
        nameLabel = UILabel()
        nameLabel.text = "张三"
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFontOfSize(13)
        mainView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel.snp_right)
            make.centerY.equalTo(nameTitleLabel)
        }
        
        cellphoneLabel = UILabel()
        mainView.addSubview(cellphoneLabel)
        cellphoneLabel.snp_makeConstraints { (make) in
            make.right.equalTo(mainView).offset(-21.pixelToPoint)
            make.centerY.equalTo(nameTitleLabel)
        }
        
        addressTitleLabel = UILabel()
        mainView.addSubview(addressTitleLabel)
        addressTitleLabel.text = "收货地址:"
        addressTitleLabel.font = UIFont.systemFontOfSize(13)
        addressTitleLabel.textColor = UIColor.init(hexString: "#333333")
        addressTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(nameTitleLabel.snp_bottom).offset(20.pixelToPoint)
            make.left.equalTo(nameTitleLabel)
            make.width.lessThanOrEqualTo(80)
        }
        
        addressLabel = UILabel()
        addressLabel.numberOfLines = 0
        addressLabel.font = UIFont.systemFontOfSize(13.0)
        addressLabel.textColor = UIColor.init(hexString: "#333333")
        addressLabel.text = "成都市高新区天府软件区G9 成都市高新区天府软件区G9成都市高新区天府软件区G9"
        mainView.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.top.equalTo(nameTitleLabel.snp_bottom).offset(20.pixelToPoint)
            make.left.equalTo(addressTitleLabel.snp_right)
            make.right.equalTo(mainView).offset(-21.pixelToPoint)
        }
        
        addressMarginView = UIView()
        addressMarginView.backgroundColor = UIColor.init(hexString: "#ebebeb")
        mainView.addSubview(addressMarginView)
        addressMarginView.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(deliverMarginView)
            make.top.equalTo(addressLabel.snp_bottom).offset(23.pixelToPoint)
        }
        
        // 商品区域
        
        goodsImageView = UIImageView()
        mainView.addSubview(goodsImageView)
        goodsImageView.image = UIImage.init(named: "placeholder")
        goodsImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(157.pixelToPoint)
            make.top.equalTo(addressMarginView.snp_bottom).offset(25.pixelToPoint)
            make.left.equalTo(mainView).offset(25.pixelToPoint)
        }
        
        goodTitleLabel = UILabel()
        goodTitleLabel.font = UIFont.systemFontOfSize(14.0)
        goodTitleLabel.textColor = UIColor.blackColor()
        goodTitleLabel.numberOfLines = 0
        goodTitleLabel.text = "成都市高新区天府软件区G9 成都市高新区天府软件区G9成都市高新区天府软件区G9"
        mainView.addSubview(goodTitleLabel)
        goodTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsImageView.snp_right).offset(27.pixelToPoint)
            make.top.equalTo(addressMarginView.snp_bottom).offset(33.pixelToPoint)
            make.right.equalTo(mainView).offset(-25.pixelToPoint)
        }
        
        priceLabel = UILabel()
        let price: NSString = "￥1000"
        let attributeString = NSMutableAttributedString.init(string: "￥1000", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#ee304e")])
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10)], range: NSMakeRange(0, 1))
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, price.length - 1))
        priceLabel.attributedText = attributeString
        
        mainView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodTitleLabel)
            make.baseline.equalTo(goodsImageView.snp_bottom)
        }
        
        
        quantityLabel = UILabel()
        mainView.addSubview(quantityLabel)
        quantityLabel.textColor = UIColor.blackColor()
        quantityLabel.font = UIFont.systemFontOfSize(14.0)
        
        quantityLabel.snp_makeConstraints { (make) in
            make.right.equalTo(goodTitleLabel.snp_right)
            make.baseline.equalTo(priceLabel)
        }
        quantityLabel.text = "x2"
        
        goodMariginView = UIView()
        goodMariginView.backgroundColor = UIColor.init(hexString: "#ebebeb")
        mainView.addSubview(goodMariginView)
        goodMariginView.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(addressMarginView)
            make.top.equalTo(goodsImageView.snp_bottom).offset(29.pixelToPoint)
        }

        customImageView = UIImageView()
        customImageView.image = UIImage.init(named: "pay_placeholder")
        mainView.addSubview(customImageView)
        customImageView.snp_makeConstraints { (make) in
            make.left.equalTo(goodsImageView)
            make.top.equalTo(goodMariginView).offset(30.pixelToPoint)
            make.width.equalTo(156.pixelToPoint)
            make.height.equalTo(121.pixelToPoint)
        }
        
        customTitleLabel = UILabel()
        mainView.addSubview(customTitleLabel)
        customTitleLabel.text = "定制图片"
        customTitleLabel.textColor = UIColor.init(hexString: "#666666")
        customTitleLabel.font = UIFont.systemFontOfSize(12.0)
        customTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(customImageView.snp_right).offset(27.pixelToPoint)
            make.top.equalTo(goodMariginView).offset(36.pixelToPoint)
            make.width.lessThanOrEqualTo(100)
        }
        
        moduleTitleLabel = UILabel()
        mainView.addSubview(moduleTitleLabel)
        moduleTitleLabel.text = "模块定制"
        moduleTitleLabel.textColor = UIColor.init(hexString: "#666666")
        moduleTitleLabel.font = UIFont.systemFontOfSize(12.0)
        moduleTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(customImageView.snp_right).offset(27.pixelToPoint)
            make.top.equalTo(customTitleLabel.snp_bottom).offset(25.pixelToPoint)
            make.width.lessThanOrEqualTo(100)
        }
        
        moduleLabel = UILabel()
        mainView.addSubview(moduleLabel)
        moduleLabel.text = "模块-"
        moduleLabel.textColor = UIColor.init(hexString: "#666666")
        moduleLabel.font = UIFont.systemFontOfSize(12.0)
        moduleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(moduleTitleLabel.snp_right).offset(8)
            make.centerY.lessThanOrEqualTo(moduleTitleLabel)
        }
        
        orderNumberTitleLabel = UILabel()
        mainView.addSubview(orderNumberTitleLabel)
        orderNumberTitleLabel.text = "订单号:"
        orderNumberTitleLabel.textColor = UIColor.init(hexString: "#666666")
        orderNumberTitleLabel.font = UIFont.systemFontOfSize(12.0)
        orderNumberTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(customImageView)
            make.top.equalTo(customImageView.snp_bottom).offset(27.pixelToPoint)
        }
        
        orderNumberLabel = UILabel()
        mainView.addSubview(orderNumberLabel)
        orderNumberLabel.text = "1021213232112"
        orderNumberLabel.textColor = UIColor.init(hexString: "#666666")
        orderNumberLabel.font = UIFont.systemFontOfSize(12.0)
        orderNumberLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderNumberTitleLabel.snp_right)
            make.centerY.equalTo(orderNumberTitleLabel)
        }
        
        orderTimeTitleLabel = UILabel()
        mainView.addSubview(orderTimeTitleLabel)
        orderTimeTitleLabel.text = "下单时间:"
        orderTimeTitleLabel.textColor = UIColor.init(hexString: "#666666")
        orderTimeTitleLabel.font = UIFont.systemFontOfSize(12.0)
        orderTimeTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(customImageView)
            make.top.equalTo(orderNumberTitleLabel.snp_bottom).offset(18.pixelToPoint)
        }
        
        orderTimeLabel = UILabel()
        mainView.addSubview(orderTimeLabel)
        orderTimeLabel.text = "2016-01-21 12:00:00"
        orderTimeLabel.textColor = UIColor.init(hexString: "#666666")
        orderTimeLabel.font = UIFont.systemFontOfSize(12.0)
        orderTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderTimeTitleLabel.snp_right)
            make.centerY.equalTo(orderTimeTitleLabel)
        }
        
        
        payTimeTitleLabel = UILabel()
        mainView.addSubview(payTimeTitleLabel)
        payTimeTitleLabel.text = "付款时间:"
        payTimeTitleLabel.textColor = UIColor.init(hexString: "#666666")
        payTimeTitleLabel.font = UIFont.systemFontOfSize(12.0)
        payTimeTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(customImageView)
            make.top.equalTo(orderTimeTitleLabel.snp_bottom).offset(18.pixelToPoint)
            make.bottom.equalTo(mainView).offset(-33.pixelToPoint)
        }
        
        payTimeLabel = UILabel()
        mainView.addSubview(payTimeLabel)
        payTimeLabel.text = "2016-01-21 12:00:00"
        payTimeLabel.textColor = UIColor.init(hexString: "#666666")
        payTimeLabel.font = UIFont.systemFontOfSize(12.0)
        payTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(payTimeTitleLabel.snp_right)
            make.centerY.equalTo(payTimeTitleLabel)
        }
        
        
        priceView = UIView()
        priceView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(priceView)
        priceView.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.top.equalTo(mainView.snp_bottom)
            make.height.equalTo(105.pixelToPoint)
        }
        
        let priceTitleLabel: UILabel = UILabel()
        priceView.addSubview(priceTitleLabel)
        priceTitleLabel.text = "订单总价"
        priceTitleLabel.textColor = UIColor.init(hexString: "#959595")
        priceTitleLabel.font = UIFont.systemFontOfSize(14.0)

        priceTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(priceView).offset(15.pixelToPoint)
            make.centerY.equalTo(priceView)
        }
        
        priceTotalLabel = UILabel()
        priceView.addSubview(priceTotalLabel)
        priceTotalLabel.snp_makeConstraints { (make) in
            make.right.equalTo(priceView).offset(-25.pixelToPoint)
            make.centerY.equalTo(priceView)
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
