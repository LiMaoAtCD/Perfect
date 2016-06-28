//
//  GoodsDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/15.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SVProgressHUD

class GoodsDetailViewController: BaseViewController, UIWebViewDelegate {
    var scrollView: UIScrollView!

    var topBanner: SDCycleScrollView!
    var goodsInfoView: UIView!
    var goodIntroView: UIView!
    var introImageViews: [UIImageView]!
    var webview: UIWebView!
    
    
    var bottomView: UIView!
    
    var detail: ProductDetailEntity?
    
    let bottomHeight = 44
    
    var id: Int64 = 0
    var favorite: Bool = false
    
    var priceLabel: UILabel!
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fd5b59")])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(28)], range: NSMakeRange(1, NSString.init(string: "\(newValue)").length - 1))
            priceLabel.attributedText = attributeString
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "商品详情"
        SVProgressHUD.showWithStatus("正在获取商品详情")
        NetworkHelper.instance.request(.GET, url: URLConstant.appGoodsDetail.contant, parameters: ["id": NSNumber.init(longLong: id)], completion: { [weak self](response: ProductDetailResponse?) in
                SVProgressHUD.dismiss()
                self?.detail = response?.retObj
                self?.favorite = response!.retObj!.favorite
                self?.updateViews()
            }) { (errMsg: String?, errCode: Int) in
                SVProgressHUD.showErrorWithStatus(errMsg ?? "商品信息获取失败")
        }
        
        scrollView = UIScrollView.init()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-bottomHeight)
        }
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
    }
    
    func updateViews() {
        configureTopBanner()
        configureGoodInfoView()
//        configureGoodIntroView()
        configureGoodIntrowebView()
        
        bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(bottomHeight)
        }
        
        configureBottomView()
    }
    
    func configureTopBanner() {
        topBanner = SDCycleScrollView.init()
        topBanner.clickItemOperationBlock = { index in
            
        }
        
        //banner 图片url
        if let images = self.detail?.images {
            var imageUrls = [String]()
            for imageId in images {
                let imageurl = imageId.perfectImageurl(664, h: 750, crop: true)
                imageUrls.append(imageurl)
            }

            topBanner.imageURLStringsGroup = imageUrls
        }
        
        scrollView.addSubview(topBanner)
        
        topBanner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        topBanner.currentPageDotColor = UIColor.redColor()
        topBanner.autoScroll = false
        topBanner.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(topBanner.snp_width).multipliedBy(664.0 / 750)
        }
        
        let shadowImageView = UIImageView.init()
        topBanner.addSubview(shadowImageView)
        shadowImageView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(topBanner)
            make.height.equalTo(9)
        }
    }
    func configureGoodInfoView() {
        goodsInfoView = UIView.init()
        goodsInfoView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(goodsInfoView)
        
        goodsInfoView.snp_makeConstraints { (make) in
            make.top.equalTo(topBanner.snp_bottom)
            make.left.right.equalTo(topBanner)
            make.height.equalTo(300)
        }
        
        let titleLabel = UILabel()
        goodsInfoView.addSubview(titleLabel)
        titleLabel.text = self.detail?.name
        titleLabel.font = UIFont.systemFontOfSize(20)
        titleLabel.textColor = UIColor.init(hexString: "#333333")
        titleLabel.numberOfLines = 0
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsInfoView).offset(24.pixelToPoint)
            make.right.equalTo(goodsInfoView).offset(-24.pixelToPoint)
            make.top.equalTo(24.pixelToPoint)
        }
        
        priceLabel = UILabel()
        
        goodsInfoView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(35.pixelToPoint)
        }
        self.price = self.detail?.price ?? 0.00
        
        
        let marketPriceLabel: MarketLabel!  = MarketLabel()
        
        goodsInfoView.addSubview(marketPriceLabel)
        marketPriceLabel.text = "市场价" + self.detail!.marketPrice.currency
        marketPriceLabel.font = UIFont.systemFontOfSize(14)
        marketPriceLabel.labelColor = UIColor.init(hexString: "#999999")
        
        marketPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(priceLabel.snp_right).offset(28.pixelToPoint)
            make.centerY.equalTo(priceLabel)
        }
        
        let homeTag = UIImageView()
        goodsInfoView.addSubview(homeTag)
        homeTag.image = UIImage.init(named: "detail_home")
        homeTag.snp_makeConstraints { (make) in
            make.height.width.equalTo(33.pixelToPoint)
            make.left.equalTo(titleLabel)
            make.top.equalTo(marketPriceLabel.snp_bottom).offset(56.pixelToPoint)
        }
        
        let companyLabel: UILabel!  = UILabel()
        
        goodsInfoView.addSubview(companyLabel)
        companyLabel.text = self.detail?.merchantName
        companyLabel.font = UIFont.systemFontOfSize(14)
        companyLabel.textColor = UIColor.init(hexString: "#666666")
        
        companyLabel.snp_makeConstraints { (make) in
            make.left.equalTo(homeTag.snp_right).offset(14.pixelToPoint)
            make.centerY.equalTo(homeTag)
        }
        
        let deliverTag = UIImageView()
        goodsInfoView.addSubview(deliverTag)
        deliverTag.image = UIImage.init(named: "detail_deliver")
        deliverTag.snp_makeConstraints { (make) in
            make.height.width.equalTo(33.pixelToPoint)
            make.left.equalTo(homeTag)
            make.top.equalTo(homeTag.snp_bottom).offset(32.pixelToPoint)
        }
        
        let deliverLabel: UILabel!  = UILabel()
        
        goodsInfoView.addSubview(deliverLabel)
        deliverLabel.text = self.detail?.deliverMemo ?? "无"
        deliverLabel.font = UIFont.systemFontOfSize(14)
        deliverLabel.textColor = UIColor.init(hexString: "#666666")
        
        deliverLabel.snp_makeConstraints { (make) in
            make.left.equalTo(deliverTag.snp_right).offset(14.pixelToPoint)
            make.centerY.equalTo(deliverTag)
        }
        
        let margin = UIView()
        goodsInfoView.addSubview(margin)
        margin.backgroundColor = UIColor.init(hexString: "#ebebeb")
        margin.snp_makeConstraints { (make) in
            make.left.right.equalTo(goodsInfoView)
            make.height.equalTo(1)
            make.top.equalTo(deliverLabel.snp_bottom).offset(50.pixelToPoint)
        }
        
        let moduleTitleLabel = UILabel()
        
        goodsInfoView.addSubview(moduleTitleLabel)
        moduleTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(31.pixelToPoint)
            make.top.equalTo(margin).offset(26.pixelToPoint)
        }
        
        moduleTitleLabel.text = "模块选择"
        moduleTitleLabel.textColor = UIColor.init(hexString: "#333333")
        moduleTitleLabel.font = UIFont.systemFontOfSize(16.0)
        
        if let products = self.detail?.products {
            if products.count > 0 {
                let moduleMargin  = 24.pixelToPoint
                let itemWidth = (Tool.width - CGFloat(products.count) * moduleMargin * 2) / CGFloat(products.count)
                for i in 0 ..< products.count {
                    let moduleView = UIButton.init(type: .Custom)
                    moduleView.tag = i
                    moduleView.layer.borderColor = UIColor.redColor().CGColor
                    moduleView.layer.borderWidth = 0.3
                    
                    goodsInfoView.addSubview(moduleView)
                    moduleView.snp_makeConstraints(closure: { (make) in
                        make.left.equalTo(moduleMargin + CGFloat(i) * (itemWidth + moduleMargin * 2))
                        make.top.equalTo(moduleTitleLabel.snp_bottom).offset(33.pixelToPoint)
                        make.width.equalTo(itemWidth)
                        make.height.equalTo(40.pixelToPoint)
                        make.bottom.equalTo(goodsInfoView.snp_bottom).offset(-20.pixelToPoint)
                    })
                }

            }
        }
        
        

    }
    
    func configureGoodIntrowebView() {
        webview = UIWebView()
        scrollView.addSubview(webview)
        
        let url  = NSURL.init(string: "http://ic.snssdk.com/wenda/wapshare/answer/brow/?ansid=6296220727066493186&iid=4584663589&app=news_article&tt_from=mobile_qq&utm_source=mobile_qq&utm_medium=toutiao_ios&utm_campaign=client_share")
        webview.loadRequest(NSURLRequest.init(URL: url!))
        webview.delegate = self
        webview.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(view)
            make.width.equalTo(Tool.width)
            make.top.equalTo(goodsInfoView.snp_bottom)
            make.bottom.equalTo(scrollView.snp_bottom)
            make.height.equalTo(1000)
        })
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if let heightString = webView.stringByEvaluatingJavaScriptFromString("document.height"),
            widthString = webView.stringByEvaluatingJavaScriptFromString("document.width"),
            height = Float(heightString),
            _ = Float(widthString) {
            
//            var rect = webView.frame
//            rect.size.height = CGFloat(height)
//            rect.size.width = CGFloat(width)
//            webView.frame = rect
            
            webview.snp_remakeConstraints(closure: { (make) in
                make.left.right.equalTo(view)
                make.width.equalTo(Tool.width)
                make.top.equalTo(goodsInfoView.snp_bottom)
                make.bottom.equalTo(scrollView.snp_bottom)
                make.height.equalTo(height)
            })
        }
    }
    
    func configureGoodIntroView() {
        
        goodIntroView = UIView()
        scrollView.addSubview(goodIntroView)
        goodIntroView.snp_makeConstraints { (make) in
            make.left.right.equalTo(topBanner)
            make.top.equalTo(goodsInfoView.snp_bottom)
        }
        
        let introDetailLabel = UILabel()
        goodIntroView.addSubview(introDetailLabel)
        introDetailLabel.text = "xcaada"
        introDetailLabel.textColor = UIColor.whiteColor()
        introDetailLabel.textAlignment = .Center
        introDetailLabel.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(goodIntroView)
            make.height.equalTo(40)
        }
        
        introImageViews = [UIImageView]()
        for i in 0...2 {
            let imageview = UIImageView()
            goodIntroView.addSubview(imageview)
            imageview.tag = i
            
            imageview.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(goodIntroView)
                make.top.equalTo(introDetailLabel.snp_bottom).offset(i * 300)
                make.height.equalTo(300)
            })
            
            imageview.image = UIImage.init(named: "fourtag")
            introImageViews.append(imageview)
        }
        
        let customStepLabel = UILabel()
        goodIntroView.addSubview(customStepLabel)
        customStepLabel.text = "xcaada"
        customStepLabel.textColor = UIColor.whiteColor()
        customStepLabel.textAlignment = .Center
        customStepLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(goodIntroView)
            make.top.equalTo(introImageViews.last!.snp_bottom)
            make.height.equalTo(40)
        }
        
        let helperView = UIView.init()
        goodIntroView.addSubview(helperView)
        helperView.snp_makeConstraints { (make) in
            make.left.right.equalTo(goodIntroView)
            make.top.equalTo(customStepLabel.snp_bottom)
            make.height.equalTo(100)
        }
        
        let margin: CGFloat = 10.0
        let width: CGFloat = (Tool.width - 6 * margin) / 5
        for i in 0...4 {
            let imageview = UIImageView.init()
            imageview.image = UIImage.init(named: "fourtag")

            helperView.addSubview(imageview)
            imageview.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(goodIntroView).offset((margin + width) * CGFloat(i) + margin)
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.top.equalTo(helperView).offset(20)
            })
            
            
            let label = UILabel.init()
            label.textColor = UIColor.blackColor()
            label.text = "xxxx"
            label.textAlignment = .Center
            
            helperView.addSubview(label)
            label.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(goodIntroView).offset((margin + width) * CGFloat(i) + margin)
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.top.equalTo(imageview.snp_bottom).offset(20)
                make.bottom.equalTo(scrollView.snp_bottom)
            })
            
        }
        
        
        
    }
    
    func tapBottomItems(tap: UITapGestureRecognizer) {
        let tag = tap.view?.tag
        if tag == 0 {
            //收藏
            if !favorite {
                
            } else {
                NetworkHelper.instance.request(.GET, url: URLConstant.setLoginMemberGoodsFavorite.contant, parameters: ["productId": NSNumber.init(longLong: self.id),"isFavorite": true], completion: { (result: DataResponse?) in
                        self.favorite = true
                    
                    }, failed: { (errmsg, code) in
                        SVProgressHUD.showErrorWithStatus(errmsg)
                })
            }

            
        } else if tag == 1 {
            //chat whth qq
            let webview = UIWebView.init()
            let url = NSURL.init(string: "mqq://im/chat?chat_type=wpa&uin=501863587&version=1&src_type=web")!
            webview.loadRequest(NSURLRequest.init(URL: url))
            webview.delegate = self
            view.addSubview(webview)

        } else {
    }

    }
    
    func configureBottomView() {
//        bottomView.layer.borderWidth = 0.5
//        bottomView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        let collect = UIView()
        
        collect.layer.borderColor = UIColor.lightGrayColor().CGColor
        collect.layer.borderWidth = 0.5
        bottomView.addSubview(collect)
        collect.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(bottomView)
            make.width.equalTo(bottomView).multipliedBy(1.0 / 3)
        }
        
        let collectionTap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapBottomItems(_:)))

        collect.tag = 0
        collect.addGestureRecognizer(collectionTap)
        
        let collectImageview = UIImageView()
        collectImageview.image = UIImage.init(named: "detail_collect")
        collect.addSubview(collectImageview)
        collectImageview.snp_makeConstraints { (make) in
            make.centerX.equalTo(collect)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(collect).offset(10)
        }
        
        let collectionTitle = UILabel()
        collect.addSubview(collectionTitle)
        collectionTitle.text = "收藏"
        collectionTitle.textColor = UIColor.init(hexString: "#333333")
        collectionTitle.font = UIFont.systemFontOfSize(14.0)

        collectionTitle.textAlignment = .Center
        collectionTitle.snp_makeConstraints { (make) in
            make.left.right.equalTo(collect)
            make.top.equalTo(collectImageview.snp_bottom)
        }
        
        
        let service = UIView()
        service.layer.borderColor = UIColor.lightGrayColor().CGColor
        service.layer.borderWidth = 0.5
        
        let serviceTap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapBottomItems(_:)))
        
        service.tag = 1
        service.addGestureRecognizer(serviceTap)


        bottomView.addSubview(service)
        service.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(bottomView)
            make.left.equalTo(collect.snp_right)
            make.width.equalTo(bottomView).multipliedBy(1.0 / 3)
        }
        
        let serviceImageview = UIImageView()
        serviceImageview.image = UIImage.init(named: "detail_kefu")
        service.addSubview(serviceImageview)
        serviceImageview.snp_makeConstraints { (make) in
            make.centerX.equalTo(service)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(service).offset(10)
        }
        
        let serviceTitle = UILabel()
        service.addSubview(serviceTitle)
        serviceTitle.text = "联系客服"
        serviceTitle.textColor = UIColor.blackColor()
        serviceTitle.font = UIFont.systemFontOfSize(14.0)
        serviceTitle.textAlignment = .Center
        serviceTitle.snp_makeConstraints { (make) in
            make.left.right.equalTo(service)
            make.top.equalTo(serviceImageview.snp_bottom)
        }
        
        let okbutton = UIButton.init(type: .Custom)
        bottomView.addSubview(okbutton)
        okbutton.setTitle("立即定制", forState: .Normal)
        okbutton.setBackgroundImage(UIImage.init(named: "detail_custom_0"), forState: .Normal)
        okbutton.setBackgroundImage(UIImage.init(named: "detail_custom_1"), forState: .Highlighted)
        okbutton.snp_makeConstraints { (make) in
            make.top.right.bottom.equalTo(bottomView)
            make.width.equalTo(bottomView).multipliedBy(1.0 / 3)
        }
        okbutton.addTarget(self, action: #selector(self.Custom), forControlEvents: .TouchUpInside)
    }
    
    func Custom() {
        let payment = Tool.sb.instantiateViewControllerWithIdentifier("PayViewController") as! PayViewController
        payment.goodEntity =  detail
        self.navigationController?.pushViewController(payment, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
