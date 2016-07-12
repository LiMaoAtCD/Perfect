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
    
    let bottomHeight = 96.pixelToPoint
    var id: Int64 = 0
    var favorite: Bool = false
    var collectionTitle: UILabel!
    
    var priceLabel: UILabel!
    
    var selectedModuleIndex: Int = 0 // 当先选择的模块
    
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            priceLabel.attributedText = attributeString
        }
    }
    
    var products: [ProductDetailModuleItem]?
    var bannerIds: [Int64] = [Int64]()
    var prices: [Float] = [Float]()
    var moduleButtons: [UIButton]!
    
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
        configureGoodIntrowebView()
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
                let imageurl = imageId.perfectImageurl(680, h: 750, crop: true)
                imageUrls.append(imageurl)
                bannerIds.append(imageId)
            }

            topBanner.imageURLStringsGroup = imageUrls
        }
        
        scrollView.addSubview(topBanner)
        
        topBanner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        topBanner.currentPageDotColor = UIColor.globalRedColor()
        topBanner.autoScroll = false
        topBanner.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(topBanner.snp_width).multipliedBy(664.0 / 750)
        }
    }
    
    func configureGoodInfoView() {
        
        goodsInfoView = UIView.init()
        goodsInfoView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(goodsInfoView)
        
        goodsInfoView.snp_makeConstraints { (make) in
            make.top.equalTo(topBanner.snp_bottom)
            make.left.right.equalTo(topBanner)
        }
        
        let moduleTitleLabel = UILabel()
        
        goodsInfoView.addSubview(moduleTitleLabel)
        moduleTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(30.pixelToPoint)
            make.top.equalTo(goodsInfoView).offset(26.pixelToPoint)
        }
        
        moduleTitleLabel.text = "模块选择"
        moduleTitleLabel.textColor = UIColor.globalDarkColor()
        moduleTitleLabel.font = UIFont.systemFontOfSize(16.0)
        
        if let products = self.detail?.products {
            if products.count > 0 {
                
                self.products = products
                if let _ = self.products {
                    for product in self.products! {
                        self.prices.append(product.price)
                    }
                }
                
                let moduleMargin  = 30.pixelToPoint
                let itemWidth = (Tool.width - CGFloat(products.count) * moduleMargin * 2) / CGFloat(products.count)
                moduleButtons = [UIButton]()
                for i in 0 ..< products.count {
                    let moduleView = UIButton.init(type: .Custom)
                    moduleView.titleLabel?.font = UIFont.systemFontOfSize(14.0)
                    moduleView.tag = i
                    moduleView.layer.borderColor = UIColor.globalRedColor().CGColor
                    moduleView.layer.borderWidth = 0.3
                    moduleView.layer.cornerRadius = 5
                    moduleView.layer.masksToBounds = true
                    moduleView.addTarget(self, action: #selector(self.switchProduct(_:)), forControlEvents: .TouchUpInside)
                    goodsInfoView.addSubview(moduleView)
                    moduleView.snp_makeConstraints(closure: { (make) in
                        make.left.equalTo(moduleMargin + CGFloat(i) * (itemWidth + moduleMargin * 2))
                        make.top.equalTo(moduleTitleLabel.snp_bottom).offset(33.pixelToPoint)
                        make.width.equalTo(itemWidth)
                        make.height.equalTo(60.pixelToPoint)
                    })
                    
                    if i == 0 {
                        moduleView.setTitle("模块一", forState: .Normal)
                    } else if i == 1 {
                        moduleView.setTitle("模块二", forState: .Normal)
                    } else if i == 2 {
                        moduleView.setTitle("模块三", forState: .Normal)
                    } else if i == 3 {
                        moduleView.setTitle("模块四", forState: .Normal)
                    }
                    moduleButtons.append(moduleView)
                }
                configureModuleButtonsSelectedStatus(0)
                
            }
        }
        
        let margin = UIView()
        goodsInfoView.addSubview(margin)
        margin.backgroundColor = UIColor.globalSeparatorColor()
        margin.snp_makeConstraints { (make) in
            make.left.right.equalTo(goodsInfoView)
            make.height.equalTo(10.pixelToPoint)
            make.top.equalTo(moduleButtons[0].snp_bottom).offset(30.pixelToPoint)
        }

        
//        make.bottom.equalTo(goodsInfoView.snp_bottom).offset(-20.pixelToPoint)


        
        let titleLabel = UILabel()
        goodsInfoView.addSubview(titleLabel)
        titleLabel.text = self.detail?.name
        titleLabel.font = UIFont.systemFontOfSize(20)
        titleLabel.textColor = UIColor.globalDarkColor()
//        titleLabel.numberOfLines = 0
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsInfoView).offset(34.pixelToPoint)
            make.right.equalTo(goodsInfoView).offset(-34.pixelToPoint)
            make.top.equalTo(margin.snp_bottom).offset(31.pixelToPoint)
        }
        
        let introduceLabel = UILabel()
        goodsInfoView.addSubview(introduceLabel)
        introduceLabel.text = self.detail?.name
        introduceLabel.font = UIFont.systemFontOfSize(14)
        introduceLabel.textColor = UIColor.globalDarkColor()
        introduceLabel.numberOfLines = 0
        
        introduceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(29.pixelToPoint)
        }
        
        introduceLabel.text = self.detail?.profile
        
        priceLabel = UILabel()
        goodsInfoView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(introduceLabel.snp_bottom).offset(30.pixelToPoint)
        }
        
        let phone_tag = UIImageView()
        goodsInfoView.addSubview(phone_tag)
        phone_tag.image = UIImage.init(named: "detail_phone_tag")
        phone_tag.snp_makeConstraints { (make) in
            make.left.equalTo(priceLabel.snp_right).offset(29.pixelToPoint)
            make.width.equalTo(73)
            make.height.equalTo(14)
            make.centerY.equalTo(priceLabel)
        }
        
        self.price = self.detail?.price ?? 0.00
        

        let deliverLabel: UILabel!  = UILabel()
        
        goodsInfoView.addSubview(deliverLabel)
        deliverLabel.text = self.detail?.deliverMemo ?? "无"
        deliverLabel.font = UIFont.systemFontOfSize(14)
        deliverLabel.textColor = UIColor.globalLightGrayColor()
        deliverLabel.numberOfLines = 0
        deliverLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsInfoView.snp_left).offset(33.pixelToPoint)
            make.right.equalTo(goodsInfoView).offset(-33.pixelToPoint)
            make.top.equalTo(priceLabel.snp_bottom).offset(34.pixelToPoint)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.globalSeparatorColor()
        goodsInfoView.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.equalTo(33.pixelToPoint)
            make.right.equalTo(-33.pixelToPoint)
            make.top.equalTo(deliverLabel.snp_bottom).offset(31.pixelToPoint)
            make.height.equalTo(1.pixelToPoint)
        }
        
        let tagImageView = UIImageView()
        tagImageView.image = UIImage.init(named: "detail_tag")
        goodsInfoView.addSubview(tagImageView)
        tagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(deliverLabel)
            make.width.equalTo(166.0)
            make.height.equalTo(28.pixelToPoint)
            make.top.equalTo(line.snp_bottom).offset(10)
            make.bottom.equalTo(goodsInfoView.snp_bottom).offset(-10.pixelToPoint)
        }
        
        self.topBanner.setScrollToIndex(0)
        self.price = self.prices[0]
   }
    
    func switchProduct(btn: UIButton) {
        self.selectedModuleIndex = btn.tag
        configureModuleButtonsSelectedStatus(btn.tag)
        let imgid = self.products![btn.tag].imgId
        
        for i in 0 ..< self.bannerIds.count {
            if self.bannerIds[i] == imgid {
                self.topBanner.setScrollToIndex(i)
                self.price = self.prices[i]
            }
        }
    }
    
    func configureModuleButtonsSelectedStatus(index: Int) {
        for i in 0 ..< moduleButtons.count {
            if i == index {
                moduleButtons[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
                moduleButtons[i].backgroundColor = UIColor.globalRedColor()
            } else {
                moduleButtons[i].setTitleColor(UIColor.globalDarkColor(), forState: .Normal)
                moduleButtons[i].backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    func configureGoodIntrowebView() {
        
        webview = UIWebView()
        scrollView.addSubview(webview)
        let urlString = id.goodDescription
        let url  = NSURL.init(string: urlString)
        webview.loadRequest(NSURLRequest.init(URL: url!))
        webview.delegate = self
        webview.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(view)
            make.width.equalTo(Tool.width)
            make.top.equalTo(goodsInfoView.snp_bottom).offset(10.pixelToPoint)
            make.bottom.equalTo(scrollView.snp_bottom)
            make.height.equalTo(0)
        })
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if let heightString = webView.stringByEvaluatingJavaScriptFromString("document.height"),
            widthString = webView.stringByEvaluatingJavaScriptFromString("document.width"),
            height = Float(heightString),
            _ = Float(widthString) {

            webview.snp_remakeConstraints(closure: { (make) in
                make.left.right.equalTo(view)
                make.width.equalTo(Tool.width)
                make.top.equalTo(goodsInfoView.snp_bottom)
                make.bottom.equalTo(scrollView.snp_bottom)
                make.height.equalTo(height)
            })
        }
    }
    
    func tapBottomItems(tap: UITapGestureRecognizer) {
        let tag = tap.view?.tag
        if tag == 0 {
            //收藏
            if !favorite {
                NetworkHelper.instance.request(.GET, url: URLConstant.setLoginMemberGoodsFavorite.contant, parameters: ["goodsId": NSNumber.init(longLong: self.id),"isFavorite": "true"], completion: { (result: DataResponse?) in
                    self.favorite = true
                    self.collectionTitle.text = "已收藏"

                    }, failed: { (errmsg, code) in
                        SVProgressHUD.showErrorWithStatus(errmsg)
                })

            } else {
                
            }
        } else if tag == 1 {
            //chat whth qq
            let webview = UIWebView.init()
            let url = NSURL.init(string: "mqq://im/chat?chat_type=wpa&uin=501863587&version=1&src_type=web")!
            webview.loadRequest(NSURLRequest.init(URL: url))
            webview.delegate = self
            view.addSubview(webview)

        } else { }

    }
    
    func configureBottomView() {
        
        bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(bottomHeight)
        }
        
        let service = UIView()
        service.layer.borderColor = UIColor.init(hexString: "#d8d8d8").CGColor
        service.layer.borderWidth = 0.3
        
        let serviceTap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapBottomItems(_:)))
        
        service.tag = 1
        service.addGestureRecognizer(serviceTap)


        bottomView.addSubview(service)
        service.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(bottomView)
            make.left.equalTo(bottomView)
            make.width.equalTo(bottomView).multipliedBy(1.0 / 3)
        }
        
        let serviceImageview = UIImageView()
        serviceImageview.image = UIImage.init(named: "detail_kefu")
        service.addSubview(serviceImageview)
        serviceImageview.snp_makeConstraints { (make) in
            make.centerX.equalTo(service)
            make.width.equalTo(33.pixelToPoint)
            make.height.equalTo(33.pixelToPoint)
            make.top.equalTo(service).offset(18.pixelToPoint)
        }
        
        let serviceTitle = UILabel()
        service.addSubview(serviceTitle)
        serviceTitle.text = "客服"
        serviceTitle.textColor = UIColor.init(hexString: "#666666")
        serviceTitle.font = UIFont.systemFontOfSize(12.0)
        serviceTitle.textAlignment = .Center
        serviceTitle.snp_makeConstraints { (make) in
            make.left.right.equalTo(service)
            make.bottom.equalTo(-15.pixelToPoint)
        }
        
        let collect = UIView()
        
        collect.layer.borderColor = UIColor.init(hexString: "#d8d8d8").CGColor
        collect.layer.borderWidth = 0.3
        bottomView.addSubview(collect)
        collect.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(bottomView)
            make.left.equalTo(service.snp_right)
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
            make.width.equalTo(33.pixelToPoint)
            make.height.equalTo(33.pixelToPoint)
            make.top.equalTo(collect).offset(10.pixelToPoint)
        }
        
        collectionTitle = UILabel()
        collect.addSubview(collectionTitle)
        collectionTitle.textColor = UIColor.init(hexString: "#666666")
        collectionTitle.font = UIFont.systemFontOfSize(12.0)
        
        collectionTitle.textAlignment = .Center
        collectionTitle.snp_makeConstraints { (make) in
            make.left.right.equalTo(collect)
            make.bottom.equalTo(-15.pixelToPoint)
        }
        
        if self.favorite {
            collectionTitle.text = "已收藏"
        } else {
            collectionTitle.text = "收藏"
        }
        

        
        let okbutton = UIButton.init(type: .Custom)
        bottomView.addSubview(okbutton)
        okbutton.setTitle("开始定制", forState: .Normal)
        okbutton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
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
        payment.goodEntity = detail
        payment.selectedIndex = self.selectedModuleIndex
        self.navigationController?.pushViewController(payment, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            label.text = ""
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



