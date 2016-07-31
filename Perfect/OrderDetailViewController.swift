//
//  OrderDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/26.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD

class OrderDetailViewController: BaseViewController,UIWebViewDelegate {

    var fromList: Bool = false
    
    var orderId: Int64 = 0
    var entity: HistoryOrderItem?
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
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length - 1))
            priceLabel.attributedText = attributeString
        }
    }
    
    var totalPrice: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length - 1))
            priceTotalLabel.attributedText = attributeString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "订单详情"
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-50)
        }
        
        //从商品详情进入
        if let _ = entity {
            fromList = true
            self.orderId = entity!.orderId
        } else {
            self.fd_interactivePopDisabled = true
        }
        
        SVProgressHUD.show()
        NetworkHelper.instance.request(.GET, url: URLConstant.appOrderDetail.contant, parameters: ["id": orderId.toNSNumber, "rows":10, "page": 1], completion: { (result: OrderDetailResponse?) in
            SVProgressHUD.dismiss()
            self.entity = result?.retObj
            self.setupScrollSubViews()
            self.bottomView?.removeFromSuperview()
            self.bottomView = UIView()
            self.view.addSubview(self.bottomView)
            self.bottomView.snp_makeConstraints { (make) in
                make.left.right.bottom.equalTo(self.view)
                make.height.equalTo(50)
            }
            self.setupBottomViews()
        }) { (msg, code) in
            SVProgressHUD.showErrorWithStatus(msg)
        }
    }
    
    override func pop() {
        if fromList {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)

        }
    }

    func setupScrollSubViews() {
        mainView?.removeFromSuperview()
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
        topLabel.text = self.entity?.orderStepName
        if let color = self.entity?.orderStepTextColor {
            topLabel.textColor = UIColor.init(hexString: color)
        }
        
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
        nameLabel.text = self.entity?.address?.consignee
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFontOfSize(13)
        mainView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel.snp_right)
            make.centerY.equalTo(nameTitleLabel)
        }
        
        cellphoneLabel = UILabel()
        cellphoneLabel.textColor = UIColor.init(hexString: "#333333")
        cellphoneLabel.font = UIFont.systemFontOfSize(13)
        cellphoneLabel.text = self.entity?.address?.phone
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
        let areaFullName = self.entity?.address?.areaFullName ?? ""
        let contactAddress = self.entity?.address?.address ?? ""
        addressLabel.text = areaFullName + contactAddress
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
        goodsImageView.kf_setImageWithURL(NSURL.init(string: self.entity!.productImageId.perfectImageurl(157, h: 157, crop: true))!, placeholderImage: UIImage.init(named: "placeholder")!, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        goodsImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(157.pixelToPoint)
            make.top.equalTo(addressMarginView.snp_bottom).offset(25.pixelToPoint)
            make.left.equalTo(mainView).offset(25.pixelToPoint)
        }
        
        goodTitleLabel = UILabel()
        goodTitleLabel.font = UIFont.systemFontOfSize(14.0)
        goodTitleLabel.textColor = UIColor.blackColor()
        goodTitleLabel.numberOfLines = 0
        goodTitleLabel.text = self.entity!.goodsName
        mainView.addSubview(goodTitleLabel)
        goodTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsImageView.snp_right).offset(27.pixelToPoint)
            make.top.equalTo(addressMarginView.snp_bottom).offset(33.pixelToPoint)
            make.right.equalTo(mainView).offset(-25.pixelToPoint)
        }
        
        priceLabel = UILabel()
        let price: NSString = self.entity!.totalPrice.currency as NSString
        let attributeString = NSMutableAttributedString.init(string: self.entity!.totalPrice.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, price.length - 1))
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
        quantityLabel.text = "x \(self.entity!.quantity)"
        
        goodMariginView = UIView()
        goodMariginView.backgroundColor = UIColor.init(hexString: "#ebebeb")
        mainView.addSubview(goodMariginView)
        goodMariginView.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(addressMarginView)
            make.top.equalTo(goodsImageView.snp_bottom).offset(29.pixelToPoint)
        }

        customImageView = UIImageView()
        customImageView.kf_setImageWithURL(NSURL.init(string: self.entity!.customImageId.perfectImageurl(121, h: 157, crop: true))!, placeholderImage: UIImage.init(named: "pay_placeholder")!, optionsInfo: nil, progressBlock: nil, completionHandler: nil)

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
        moduleLabel.text = self.entity!.productName
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
        orderNumberLabel.text = self.entity!.orderSn
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
        orderTimeLabel.text = self.entity!.orderCreateDate
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
        payTimeLabel.text = "无"
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
        let totalPrice: NSString = self.entity!.totalPrice.currency as NSString
        let totalPriceAttributeString = NSMutableAttributedString.init(string: totalPrice as String, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
        totalPriceAttributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
        totalPriceAttributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, totalPrice.length - 1))
        priceTotalLabel.attributedText = totalPriceAttributeString
        
        priceView.addSubview(priceTotalLabel)
        priceTotalLabel.snp_makeConstraints { (make) in
            make.right.equalTo(priceView).offset(-25.pixelToPoint)
            make.centerY.equalTo(priceView)
        }
    }
    
    func setupBottomViews() {
        let kefuImageView = UIImageView()
        kefuImageView.image = UIImage.init(named: "order_kefu")
        bottomView.addSubview(kefuImageView)
        kefuImageView.snp_makeConstraints { (make) in
            make.left.equalTo(31.pixelToPoint)
            make.centerY.equalTo(bottomView)
            make.width.equalTo(96.pixelToPoint)
            make.height.equalTo(81.pixelToPoint)
        }
        
        let contactKefu = UILabel()
        bottomView.addSubview(contactKefu)
        contactKefu.text = "联系客服"
        contactKefu.font = UIFont.systemFontOfSize(15)
        contactKefu.textColor = UIColor.init(hexString: "#666666")
        contactKefu.snp_makeConstraints { (make) in
            make.left.equalTo(kefuImageView.snp_right).offset(17.pixelToPoint)
            make.centerY.equalTo(kefuImageView)
        }
        
        let contactKeFuButton = UIButton()
        bottomView.addSubview(contactKeFuButton)
        contactKeFuButton.snp_makeConstraints { (make) in
            make.left.equalTo(kefuImageView)
            make.right.equalTo(contactKefu)
            make.height.equalTo(bottomView)
            make.centerY.equalTo(bottomView)
        }
        
        contactKeFuButton.addTarget(self, action: #selector(self.contact), forControlEvents: .TouchUpInside)
        
        let button1 = UIButton.init(type: .Custom)
        bottomView.addSubview(button1)
        button1.snp_makeConstraints { (make) in
            make.right.equalTo(-42.pixelToPoint)
            make.centerY.equalTo(bottomView)
//            make.width.equalTo(128.pixelToPoint)
//            make.height.equalTo(47.pixelToPoint)
            make.width.equalTo(84)
            make.height.equalTo(31)
        }

        if let orderStepCode = entity?.orderStepCode {
            if orderStepCode == "unpaid" {
                button1.setImage(UIImage.init(named: "order_pay_0"), forState: .Normal)
                button1.setImage(UIImage.init(named: "order_pay_1"), forState: .Highlighted)
                button1.addTarget(self, action: #selector(self.pay), forControlEvents: .TouchUpInside)

            } else if orderStepCode == "offlinePayPending" {
                //付款说明的UI
                button1.setImage(UIImage.init(named: "detail_pay_intro"), forState: .Normal)
                button1.setImage(UIImage.init(named: "detail_pay_intro"), forState: .Highlighted)
                button1.addTarget(self, action: #selector(self.payTip), forControlEvents: .TouchUpInside)
                
            } else if orderStepCode == "confirmPending" {
            
            }else if orderStepCode == "unshipped" {
                
            }else if orderStepCode == "shipped" {
                button1.setImage(UIImage.init(named: "order_confirm_0"), forState: .Normal)
                button1.setImage(UIImage.init(named: "order_confirm_1"), forState: .Highlighted)
                button1.addTarget(self, action: #selector(self.shipped), forControlEvents: .TouchUpInside)
            } else if orderStepCode == "receiptConfirmed" {
                
            } else {
            }
        }
    }
    
    func pay() {
        //支付。。。。
    }
    
    func payTip() {
        let offlineVC = OfflinePayViewController.someController(OfflinePayViewController.self, ofStoryBoard: UIStoryboard.main)
        offlineVC.orderId = entity!.orderId
        offlineVC.fromDetail = true
        self.navigationController?.pushViewController(offlineVC, animated: true)
    }
    
    func shipped() {
        //确认收货
        NetworkHelper.instance.request(.GET, url: URLConstant.appConfirmReceipt.contant, parameters: ["orderId": orderId.toNSNumber], completion: { (result: DataResponse?) in
                //  重新加载本页面
//                self.refetchOrderStatus()
                SVProgressHUD.showSuccessWithStatus("确认收货成功")
                Async.main(after: 1.0, block: {
                    self.navigationController?.popViewControllerAnimated(true)
                })
            
            }) { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)
        }
    }
    
    func refetchOrderStatus() {
        SVProgressHUD.show()
        NetworkHelper.instance.request(.GET, url: URLConstant.appOrderDetail.contant, parameters: ["id": orderId.toNSNumber, "rows":10, "page": 1], completion: { (result: OrderDetailResponse?) in
            SVProgressHUD.dismiss()
            self.entity = result?.retObj
            self.setupScrollSubViews()
            self.bottomView = UIView()
            self.view.addSubview(self.bottomView)
            self.bottomView.snp_makeConstraints { (make) in
                make.left.right.bottom.equalTo(self.view)
                make.height.equalTo(50)
            }
            self.setupBottomViews()
        }) { (msg, code) in
            SVProgressHUD.showErrorWithStatus(msg)
        }

    }
    
    func contact() {
        let webview = UIWebView.init()
        let url = NSURL.init(string: "mqq://im/chat?chat_type=wpa&uin=2881876374&version=1&src_type=web")!
        webview.loadRequest(NSURLRequest.init(URL: url))
        webview.delegate = self
        view.addSubview(webview)

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

enum DetailType: Int {
    case Pay = 1
    case Confirm = 2
    case Tousu = 3
}
