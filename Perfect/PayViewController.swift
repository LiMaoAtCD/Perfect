//
//  PayViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

enum PayType: Int {
    case Offline = 0
    case Wechat = 1
    case Alipay = 2
}

class PayViewController: BaseViewController {

    var scrollView: UIScrollView!
    var buyerView: UIView! // 收货信息视图
    var addAddressView: UIView!
    
    var nameLabel: UILabel!//收货人
    var contactLabel: UILabel!//联系电话
    var addressLabel: UILabel!//地址
    var addressString: String = ""
    var detailAddress = "" //详细地址
    var contactName = "" {
        willSet {
            self.nameLabel?.text = newValue
        }
    }
    var contactPhone = "" {
        willSet {
            self.contactLabel?.text = newValue
        }
    }
    
    
    var areaId: Int64 = -1
    var addressItemEntity: AddressItemsEntity? {
        willSet{
            if let _ = newValue {
                self.addressString = newValue!.areaFullName! + newValue!.contactAddress!
                self.addressLabel?.text = newValue!.areaFullName! + newValue!.contactAddress!
                self.contactName = newValue!.contactName!
                self.contactPhone = newValue!.contactPhone!
                self.detailAddress = newValue!.contactAddress!
                self.areaId = newValue!.areaId
            }
        }
    }
    

    //订单部分
    var customView: UIView!
    var goodsTitle: UILabel! //商品信息
    var previewImageview: UIImageView! //商品预览图
    var priceLabel: UILabel! //商品单价
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            priceLabel.attributedText = attributeString
            self.totalPrice = newValue * Float(quantity)
        }
    }
    
    var totalPrice: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(20)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(20)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            totalPriceLabel.attributedText = attributeString
        }
    }
    
    var numberTextField: UITextField! //商品数量输入框
    var mininumber = 1   //最小数量
    var payType: PayType = .Offline
    var myGoodImageView: UIImageView!
    //支付信息
    var payTypeViews: [PayTypeView]!
    //底部合计
    var bottomView: UIView!
    var totalPriceLabel = UILabel()
    
    var goodEntity: ProductDetailEntity?
    var productId: Int64 = 0
    var quantity: Int = 1
    var customImgId: Int64 = 0
    var selectedIndex: Int = 0 //用于模块ID，模块价格 和对应图片
    
    
    var moduleButtons: [UIButton]!   //模块按钮
    var products: [ProductDetailModuleItem]?
    var goodImageIds: [Int64] = [Int64]()
    var prices: [Float] = [Float]()
    var moduleIds: [Int64] = [Int64]()
    
    var currentGoodImageId: Int64 = 0 {
        willSet {
            self.previewImageview.kf_setImageWithURL(NSURL.init(string: newValue.perfectImageurl(200, h: 200, crop: true))!)
        }
    }
    
    var orderId: Int64 = 0 //订单ID

    func renewViews() {
        configureBuyerView()
        configureGoodView()
        configurePayView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let realm = try! Realm()
        let addresses = realm.objects(AddressItemsEntity)
        if addresses.isEmpty {

            addressItemEntity = nil
            renewViews()
            self.price = self.products![self.selectedIndex].price
            self.productId = self.products![selectedIndex].id

        } else {
            renewViews()
            self.price = self.products![self.selectedIndex].price
            self.productId = self.products![selectedIndex].id

        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        NSNotificationCenter.defaultCenter().postNotificationName("AliPayCallBack", object: nil, userInfo: resultDic)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.alipayCallback), name: "AliPayCallBack", object: nil)

        self.prices = [Float]()
        self.goodImageIds = [Int64]()
        self.moduleIds = [Int64]()
        
        
        
        if let products = goodEntity?.products {
            for product in products {
                self.prices.append(product.price)
                self.goodImageIds.append(product.imgId)
                self.moduleIds.append(product.id)
            }
        }

        
        let realm = try! Realm()
        let addresses = realm.objects(AddressItemsEntity)
        if !addresses.isEmpty {
            for address in addresses {
                if address.isDefault {
                    addressItemEntity = address
                }
            }
            if let _ = addressItemEntity {
            } else {
                addressItemEntity = addresses.first
            }
        } else {
            
        }

        configureScrollView()
        configureBuyerView()
        configureGoodView()
        configurePayView()
        configureTotalView()
    }
    
    //MARK:  支付宝回调
    func alipayCallback(notification: NSNotification) {
        let obj = notification.userInfo
        
        if let _ = obj {
            
        }
        guard let result = obj else {
            return
        }
        
        guard let resultStatus = result["resultStatus"] else {
            return
        }

        let statusCode = resultStatus as? String
        if let _ = statusCode {
            if statusCode! == "9000" {
                //支付成功 ，跳到订单详情
                
                let orderDetailVC = OrderDetailViewController.someController(OrderDetailViewController.self, ofStoryBoard: UIStoryboard.main)
                orderDetailVC.orderId = self.orderId
                self.navigationController?.pushViewController(orderDetailVC, animated: true)
            } else {
                
                if let memo = result["memo"] as? String {
                    SVProgressHUD.showErrorWithStatus(memo)
                } else {
                    SVProgressHUD.showErrorWithStatus("支付未成功，请重新支付")
                }
            }
        }
        
        
        
        print(obj)
        
    }


    
    //MARK: scrollview
    func configureScrollView() {
        scrollView = UIScrollView.init()
        scrollView.backgroundColor = UIColor.init(hexString: "#efefef")
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-50)
        }
        
        scrollView.delaysContentTouches = false
        scrollView.alwaysBounceVertical = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismiss))
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismiss() {
        self.numberTextField.resignFirstResponder()
    }
    
    func configureBuyerView() {
        
        if let _ = addressItemEntity {
            addAddressView?.removeFromSuperview()
            addAddressView = nil
            
            buyerView = UIView()
            buyerView.backgroundColor = UIColor.whiteColor()
            scrollView.addSubview(buyerView)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.changeAddress))
            buyerView.addGestureRecognizer(tap)
            
            let titleLabel = UILabel()
            buyerView.addSubview(titleLabel)
            titleLabel.text = "收货地址"
            titleLabel.textColor = UIColor.init(hexString: "#333333")
            titleLabel.font = UIFont.systemFontOfSize(17)
            titleLabel.snp_makeConstraints { (make) in
                make.left.equalTo(buyerView).offset(24.pixelToPoint)
                make.top.equalTo(buyerView).offset(27.pixelToPoint)
                make.width.lessThanOrEqualTo(80).priority(1000)
            }
            
            nameLabel = UILabel()
            buyerView.addSubview(nameLabel)
            nameLabel.snp_makeConstraints { (make) in
                make.left.equalTo(titleLabel.snp_right).offset(105.pixelToPoint)
                make.baseline.equalTo(titleLabel)
            }
            nameLabel.text = contactName
            nameLabel.textColor = UIColor.init(hexString: "#333333")
            nameLabel.font = UIFont.systemFontOfSize(14)
            
            contactLabel = UILabel()
            buyerView.addSubview(contactLabel)
            contactLabel.snp_makeConstraints { (make) in
                make.left.equalTo(nameLabel.snp_right).offset(49.pixelToPoint)
                make.centerY.equalTo(nameLabel)
            }
            contactLabel.text = contactPhone
            contactLabel.textColor = UIColor.init(hexString: "#333333")
            contactLabel.font = UIFont.systemFontOfSize(14)
            
            addressLabel = UILabel()
            addressLabel.text = addressString
            
            addressLabel.numberOfLines = 0
            addressLabel.textColor = UIColor.init(hexString: "#333333")
            addressLabel.font = UIFont.systemFontOfSize(14)
            buyerView.addSubview(addressLabel)
            addressLabel.snp_makeConstraints { (make) in
                make.left.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp_bottom).offset(36.pixelToPoint)
                make.right.equalTo(buyerView.snp_right).offset(-43.pixelToPoint)
            }
            
            buyerView.snp_makeConstraints { (make) in
                make.left.right.equalTo(view)
                make.top.equalTo(scrollView).offset(20.pixelToPoint)
            }
            
            let goAddress = UIImageView()
            goAddress.image = UIImage.init(named: "pay_goAddress")
            buyerView.addSubview(goAddress)
            goAddress.snp_makeConstraints { (make) in
                make.height.equalTo(26.pixelToPoint)
                make.width.equalTo(20.pixelToPoint)
                make.top.equalTo(buyerView).offset(27.pixelToPoint)
                make.right.equalTo(-28.pixelToPoint)
            }
            
            let addressImageView = UIImageView()
            addressImageView.image = UIImage.init(named: "pay_address")
            buyerView.addSubview(addressImageView)
            addressImageView.snp_makeConstraints { (make) in
                make.height.equalTo(26.pixelToPoint)
                make.left.right.equalTo(buyerView)
                make.bottom.equalTo(buyerView)
                make.top.equalTo(addressLabel.snp_bottom).offset(30.pixelToPoint)
            }

        } else {
            buyerView?.removeFromSuperview()
            buyerView = nil
            
            addAddressView = UIView.init()
            addAddressView.backgroundColor = UIColor.whiteColor()
            scrollView.addSubview(addAddressView)
            
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.changeAddress))
            
            addAddressView.addGestureRecognizer(tap)
            
            addAddressView.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(view)
                make.top.equalTo(scrollView)
                make.height.equalTo(95.pixelToPoint)
            })
            
            let tempView = UIView()
            addAddressView.addSubview(tempView)
            tempView.snp_makeConstraints(closure: { (make) in
                make.center.equalTo(addAddressView)
                
            })
            
            let addButton = UIImageView.init(image: UIImage.init(named: "address_add")!)
            addAddressView.addSubview(addButton)
            addButton.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(tempView)
                make.height.width.equalTo(32.pixelToPoint)
                make.centerY.equalTo(tempView)
            })
            
            let addTitle = UILabel()
            addTitle.text = "添加收件地址"
            addTitle.textColor = UIColor.globalDarkColor()
            addAddressView.addSubview(addTitle)
            addTitle.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(addButton.snp_right).offset(19.pixelToPoint)
                make.centerY.equalTo(addButton)
                make.right.equalTo(tempView)
            })
        }
        
   }
    
    func configureGoodView() {
        customView?.removeFromSuperview()
        customView = UIView()
        customView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(customView)
        
        if let _ = addressItemEntity {
            customView.snp_remakeConstraints { (make) in
                make.left.right.equalTo(view)
                make.top.equalTo(buyerView.snp_bottom).offset(10.pixelToPoint)
            }
        } else {
            customView.snp_remakeConstraints { (make) in
                make.left.right.equalTo(view)
                make.top.equalTo(addAddressView.snp_bottom).offset(10.pixelToPoint)
            }
        }
   
        
        let title = UILabel()
        title.text = "订单商品"
        title.textColor = UIColor.globalDarkColor()
        title.font = UIFont.systemFontOfSize(16)
        customView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(customView).offset(24.pixelToPoint)
            make.centerY.equalTo(customView.snp_top).offset(72.pixelToPoint / 2)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        let line = UIView()
        customView.addSubview(line)
        line.backgroundColor = UIColor.globalSeparatorColor()
        line.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(-24.pixelToPoint)
            make.top.equalTo(title.snp_bottom).offset(8)
            make.height.equalTo(1.pixelToPoint)
        }
        
        let mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        customView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(customView).offset(-14)
            make.top.equalTo(line.snp_bottom).offset(19)
            make.bottom.equalTo(customView).offset(-8)
        }
        
        previewImageview = UIImageView()
        previewImageview.kf_setImageWithURL(NSURL.init(string: self.goodImageIds[self.selectedIndex].perfectImageurl(200, h: 200, crop: true))!)
        mainView.addSubview(previewImageview)
        previewImageview.snp_makeConstraints { (make) in
            make.left.equalTo(18.pixelToPoint)
            make.width.height.equalTo(200.pixelToPoint)
            make.top.equalTo(26.pixelToPoint)
        }
        
        goodsTitle = UILabel.init()
        goodsTitle.numberOfLines = 0
        goodsTitle.textColor = UIColor.globalDarkColor()
        goodsTitle.font = UIFont.systemFontOfSize(16.0)
        mainView.addSubview(goodsTitle)
        goodsTitle.snp_makeConstraints { (make) in
            make.left.equalTo(previewImageview.snp_right).offset(19.pixelToPoint)
            make.right.equalTo(mainView).offset(-39.pixelToPoint)
            make.top.equalTo(mainView).offset(38.pixelToPoint)
        }
        goodsTitle.text = self.goodEntity!.name
        
        priceLabel = UILabel()
        mainView.addSubview(priceLabel)
        
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsTitle)
            make.width.equalTo(140)
            make.bottom.equalTo(previewImageview).offset(-20.pixelToPoint)
            make.height.equalTo(30)
        }
        
        let marginView = UIView()
        marginView.backgroundColor = UIColor.globalSeparatorColor()
        
        mainView.addSubview(marginView)
        marginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.height.equalTo(1.pixelToPoint)
            make.top.equalTo(previewImageview.snp_bottom).offset(8)
        }
        
        //数量选择器
        let numberView = UIView()
        customView.addSubview(numberView)
        numberView.snp_makeConstraints { (make) in
            make.right.equalTo(-46.pixelToPoint)
            make.width.equalTo(75)
            make.height.equalTo(22)
            make.bottom.equalTo(marginView).offset(-29.pixelToPoint)
        }
        
        let numberBgView = UIImageView()
        numberBgView.image = UIImage.init(named: "pay_number_choose")
        numberView.addSubview(numberBgView)
        numberBgView.snp_makeConstraints { (make) in
            make.edges.equalTo(numberView)
        }
        
        numberTextField = UITextField()
        numberView.addSubview(numberTextField)
        numberTextField.font = UIFont.systemFontOfSize(12.0)
        numberTextField.text = String(self.quantity)
        numberTextField.snp_makeConstraints { (make) in
            make.edges.equalTo(numberView)
        }
        numberTextField.textAlignment = .Center
        numberTextField.keyboardType = .NumberPad
        numberTextField.addTarget(self, action: #selector(self.changeNumber(_:)), forControlEvents: .EditingChanged)
        let leftButton = UIButton.init(type: .Custom)
        leftButton.addTarget(self, action: #selector(self.increaseNumber), forControlEvents: .TouchUpInside)
        numberView.addSubview(leftButton)
        leftButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(numberView)
            make.width.equalTo(numberView).multipliedBy(0.3)
        }
        
        let rightButton = UIButton.init(type: .Custom)
        rightButton.addTarget(self, action: #selector(self.addNumber), forControlEvents: .TouchUpInside)
        numberView.addSubview(rightButton)
        rightButton.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(numberView)
            make.width.equalTo(numberView).multipliedBy(0.3)
        }
        
        myGoodImageView = UIImageView()
        mainView.addSubview(myGoodImageView)
        if self.customImgId == 0 {
            myGoodImageView.image = UIImage.init(named: "pay_placeholder")
        } else {
            myGoodImageView.kf_setImageWithURL(NSURL.init(string: customImgId.perfectImageurl(200, h: 151, crop: true))!)
        }
        
        myGoodImageView.snp_makeConstraints { (make) in
            make.left.equalTo(previewImageview)
            make.width.equalTo(200.pixelToPoint)
            make.top.equalTo(marginView).offset(22.pixelToPoint)
            make.height.equalTo(151.pixelToPoint)
        }
        
        let tipTitle = UILabel()
        tipTitle.text = "左图为定制图案"
        tipTitle.textColor = UIColor.init(hexString: "#999999")
        tipTitle.font = UIFont.systemFontOfSize(13)
        mainView.addSubview(tipTitle)
        tipTitle.snp_makeConstraints { (make) in
            make.left.equalTo(myGoodImageView.snp_right).offset(19.pixelToPoint)
            make.top.equalTo(marginView).offset(34.pixelToPoint)
        }
        
        let changeButton = UIButton.init()
        changeButton.setTitle("更换定制图", forState: .Normal)
        changeButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        changeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changeButton.setBackgroundImage(UIImage.init(named: "detail_custom_0"), forState: .Normal)
        changeButton.setBackgroundImage(UIImage.init(named: "detail_custom_1"), forState: .Highlighted)
        changeButton.layer.cornerRadius = 10.pixelToPoint
        changeButton.layer.masksToBounds = true
        changeButton.addTarget(self, action: #selector(self.custom), forControlEvents: .TouchUpInside)
        mainView.addSubview(changeButton)
        
        changeButton.snp_makeConstraints { (make) in
            make.right.equalTo(mainView).offset(-16.pixelToPoint)
            make.width.equalTo(199.pixelToPoint)
            make.height.equalTo(72.pixelToPoint)
            make.top.equalTo(marginView.snp_bottom).offset(78.pixelToPoint)
        }
        
        let moduleMarginView = UIView()
        moduleMarginView.backgroundColor = UIColor.globalSeparatorColor()
        mainView.addSubview(moduleMarginView)
        moduleMarginView.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(marginView)
            make.top.equalTo(myGoodImageView.snp_bottom).offset(24.pixelToPoint)
        }
        
        let moduleChoosenLabel = UILabel()
        mainView.addSubview(moduleChoosenLabel)
        moduleChoosenLabel.text = "模块选择"
        moduleChoosenLabel.font = UIFont.systemFontOfSize(15.0)
        moduleChoosenLabel.textColor = UIColor.init(hexString: "333333")
        moduleChoosenLabel.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(moduleMarginView).offset(42.pixelToPoint)
        }
        
        if let products = self.goodEntity?.products {
            if products.count > 0 {
                
                self.products = products
                if let _ = self.products {
                    for product in self.products! {
                        self.prices.append(product.price)
                    }
                }
                
                let moduleMargin = 10.pixelToPoint
                let itemWidth = (Tool.width - 28 - CGFloat(products.count) * moduleMargin * 2) / CGFloat(products.count)
                moduleButtons = [UIButton]()
                for i in 0 ..< products.count {
                    let moduleView = UIButton.init(type: .Custom)
                    moduleView.tag = i
                    moduleView.layer.borderColor = UIColor.redColor().CGColor
                    moduleView.layer.borderWidth = 0.3
                    moduleView.layer.cornerRadius = 5
                    moduleView.layer.masksToBounds = true
                    moduleView.titleLabel?.font = UIFont.systemFontOfSize(14.0)
                    moduleView.addTarget(self, action: #selector(self.switchProduct(_:)), forControlEvents: .TouchUpInside)
                    mainView.addSubview(moduleView)
                    
                    moduleView.snp_makeConstraints(closure: { (make) in
                        make.left.equalTo(moduleMargin + CGFloat(i) * (itemWidth + moduleMargin * 2))
                        make.top.equalTo(moduleChoosenLabel.snp_bottom).offset(33.pixelToPoint)
                        make.width.equalTo(itemWidth)
                        make.height.equalTo(60.pixelToPoint)
                        make.bottom.equalTo(mainView.snp_bottom).offset(-20.pixelToPoint)
                    })
                    
                    if i == 0 {
                        moduleView.setTitle("模块一", forState: .Normal)
                    } else if i == 1 {
                        moduleView.setTitle("模块二", forState: .Normal)
                    } else if i == 2 {
                        moduleView.setTitle("模块三", forState: .Normal)
                    } else if i == 3 {
                        moduleView.setTitle("模块四", forState: .Normal)
                    } else if i == 4 {
                        moduleView.setTitle("模块五", forState: .Normal)
                    }
                    moduleButtons.append(moduleView)
                }
                configureModuleButtonsSelectedStatus(self.selectedIndex)
            }
        }

    }
    
    func switchProduct(btn: UIButton) {
        configureModuleButtonsSelectedStatus(btn.tag)
        let imgid = self.products![btn.tag].imgId
        for i in 0 ..< self.goodImageIds.count {
            if self.goodImageIds[i] == imgid {
                self.price = self.prices[i]
                self.currentGoodImageId = imgid
                self.productId = self.products![i].id
            }
        }
    }
    
    func configureModuleButtonsSelectedStatus(index: Int) {
        for i in 0 ..< moduleButtons.count {
            if i == index {
                moduleButtons[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
                moduleButtons[i].backgroundColor = UIColor.globalRedColor()
            } else {
                moduleButtons[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
                moduleButtons[i].backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    var payView: UIView!
    func configurePayView() {
        
        payView?.removeFromSuperview()
        payView = UIView()
        payView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(payView)
        payView.snp_makeConstraints { (make) in
            make.left.right.equalTo(customView)
            make.top.equalTo(customView.snp_bottom).offset(10.pixelToPoint)
            make.bottom.equalTo(scrollView)
        }
        
        let title = UILabel()
        title.text = "支付方式"
        title.textColor = UIColor.init(hexString: "#333333")
        title.font = UIFont.systemFontOfSize(16)
        payView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(payView).offset(24.pixelToPoint)
            make.centerY.equalTo(payView.snp_top).offset(72.pixelToPoint / 2)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        let line = UIView()
        payView.addSubview(line)
        line.backgroundColor = UIColor.globalSeparatorColor()
        line.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(-24.pixelToPoint)
            make.top.equalTo(title.snp_bottom).offset(8)
            make.height.equalTo(1.pixelToPoint)
        }
        
        let mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        payView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(customView).offset(-14)
            make.top.equalTo(line.snp_bottom).offset(19)
            make.bottom.equalTo(payView).offset(-47.pixelToPoint)
        }
        
        let payItemMargin: CGFloat = 30
        let payItemWidth = ((Tool.width - 2 * 14) - 4 * payItemMargin) / 3
        payTypeViews = [PayTypeView]()
        for i in 0...2 {
            let payitemView = PayTypeView.init(frame: CGRectZero)
            payitemView.tag = i
            payitemView.backgroundColor = UIColor.whiteColor()
            mainView.addSubview(payitemView)
            payitemView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(20 + payItemMargin + (payItemWidth + payItemMargin) * CGFloat(i))
                make.width.equalTo(payItemWidth)
                make.height.equalTo(70)
                make.top.equalTo(mainView).offset(14)
                make.bottom.equalTo(mainView.snp_bottom)
            })
            
            payitemView.clickHandler = {
                tag in
                switch tag {
                case 0:
                    self.payTypeViews[0].isChecked = true
                    self.payTypeViews[1].isChecked = false
                    self.payTypeViews[2].isChecked = false
                    self.payType = .Offline
                case 1:
                    self.payTypeViews[0].isChecked = false
                    self.payTypeViews[1].isChecked = true
                    self.payTypeViews[2].isChecked = false
                    self.payType = .Alipay
                case 2:
                    self.payTypeViews[0].isChecked = false
                    self.payTypeViews[1].isChecked = false
                    self.payTypeViews[2].isChecked = true
                    self.payType = .Wechat
                default:
                    break
                }
            }
            payitemView.isChecked = false
            self.payTypeViews.append(payitemView)
            
            if i == 0 {
                payitemView.imageView.image = UIImage.init(named: "pay_offline")
                payitemView.title.text = "线下"
            } else if i == 1 {
                payitemView.imageView.image = UIImage.init(named: "pay_alipay")
                payitemView.title.text = "支付宝"
               
            } else {
                payitemView.userInteractionEnabled = false
                payitemView.imageView.image = UIImage.init(named: "pay_wechat")
                payitemView.title.text = "微信"
                payitemView.title.textColor = UIColor.globalLightGrayColor()

            }
        }
        
        payTypeViews[payType.rawValue].isChecked = true
    }
    
    func configureTotalView() {
        bottomView = UIView()
        bottomView.layer.borderColor = UIColor.globalSeparatorColor().CGColor
        bottomView.layer.borderWidth = 0.3
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.top.equalTo(scrollView.snp_bottom)
        }
        
        
        let settleButton = UIButton.init(type: .Custom)
        bottomView.addSubview(settleButton)
        settleButton.titleLabel?.font = UIFont.boldSystemFontOfSize(18.0)
        settleButton.setTitle("合计结算", forState: .Normal)
        settleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        settleButton.setBackgroundImage(UIImage.init(named: "detail_custom_1"), forState: .Normal)
        settleButton.setBackgroundImage(UIImage.init(named: "detail_custom_1"), forState: .Highlighted)
        settleButton.addTarget(self, action: #selector(self.submitOrder), forControlEvents: .TouchUpInside)
        
        settleButton.snp_makeConstraints { (make) in
            make.width.equalTo(235.pixelToPoint)
            make.right.height.top.equalTo(bottomView)
        }
        
        totalPriceLabel = UILabel()
        bottomView.addSubview(totalPriceLabel)
        totalPriceLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(settleButton)
            make.left.equalTo(bottomView).offset(35.pixelToPoint)
            make.height.equalTo(bottomView)
//            make.width.lessThanOrEqualTo(150).priority(250)
        }
    }
    
    
    //MARK: 点击事件处理
    
    func changeAddress() {
        let addressVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddressViewController") as! AddressViewController
        addressVC.hidesBottomBarWhenPushed = true
        addressVC.selectedHandler = {
            [weak self] item in
            self?.addressItemEntity = item
            self?.renewViews()
        }
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    func addNumber() {
        self.quantity = self.quantity + 1
        self.numberTextField.text = String(self.quantity)
        
        self.totalPrice = price * Float(self.quantity)
    }
    
    func increaseNumber() {
        self.quantity = self.quantity - 1
        if self.quantity < mininumber {
            self.quantity = mininumber
        }
        self.numberTextField.text = String(self.quantity)
        self.totalPrice = price * Float(self.quantity)

    }
    
    func changeNumber(textfield: UITextField) {
        if let _ = textfield.text {
            let number = Int(textfield.text!)
            if let _ = number {
                self.quantity = number!
                if self.quantity < mininumber {
                    self.quantity = mininumber
                }
            }
        }
        
        self.totalPrice = price * Float(self.quantity)

    }
    
    func custom() {

        
        let customImageVC = CustomGoodImageController.someController(CustomGoodImageController.self, ofStoryBoard: UIStoryboard.main)
        customImageVC.completeHandler = {
            [weak self](imgId, image) in
            //            self?.myGoodImageView.image = image
            self?.customImgId = imgId
        }
        self.navigationController?.pushViewController(customImageVC, animated: true)
    }
    

    
    func submitOrder() {
        
 
        
        if productId == 0 {
            SVProgressHUD.showErrorWithStatus("未选择模块")
            return
        }
        
        guard let _ = addressItemEntity else {
            SVProgressHUD.showErrorWithStatus("收货信息不能为空")
            return
        }
        
        guard customImgId != 0 else {
            SVProgressHUD.showErrorWithStatus("请上传定制图片")
            return
        }
        if addressItemEntity!.invalidated {
            self.addressLabel.text = "请完善您的收货信息"
            self.contactLabel.text = ""
            self.nameLabel.text = ""
            SVProgressHUD.showErrorWithStatus("您的收获地址已被删除")
            return
        }
        
        var payTypeString: String = ""
        if payType == .Offline {
            payTypeString = "offline"
        } else if payType == .Wechat {
            payTypeString = "wechat"
        } else {
            payTypeString = "alipay"
        }
        
        SVProgressHUD.show()
        NetworkHelper.instance.request(.GET, url: URLConstant.appConfirmOrder.contant, parameters: [
            "productId":productId.toNSNumber,
            "quantity":quantity,
            "addressId": addressItemEntity!.id.toNSNumber,
            "contactAddress": detailAddress,
            "contactName": contactName,
            "contactPhone": contactPhone,
            "customImgId": customImgId.toNSNumber,
            "payType": payTypeString],
                                       
           completion: { (result: ConfirmOrderResponse?) in
            
            
//                let orderDetailVC = OrderDetailViewController.someController(OrderDetailViewController.self, ofStoryBoard: UIStoryboard.main)
//                orderDetailVC.orderId = result!.retObj!.orderId
//            self.navigationController?.pushViewController(orderDetailVC, animated: true)
//            
//            let offVC = OfflinePayViewController.someController
//            (OfflinePayViewController.self, ofStoryBoard: UIStoryboard.main)
//            
//            offVC.or = result!.retObj!.orderId
//
//            self.navigationController?.pushViewController(offlineVC, animated: true)
            
            if let id = result?.retObj?.orderId {
                self.orderId = id
            }
            
            if payTypeString == "offline" {
                SVProgressHUD.dismiss()

                let offlineVC = OfflinePayViewController.someController(OfflinePayViewController.self, ofStoryBoard: UIStoryboard.main)
                
                offlineVC.orderId = result!.retObj!.orderId
                
                self.navigationController?.pushViewController(offlineVC, animated: true)
            } else if payTypeString == "alipay" {
                SVProgressHUD.dismiss()
                let orderString = result!.retObj!.paymentData
                AlipaySDK.defaultService().payOrder(orderString, fromScheme: "perfect", callback: { (result: [NSObject : AnyObject]!) in
                    print(result)
                })
            }
        }) { (errMsg, errCode) in
            SVProgressHUD.showErrorWithStatus(errMsg)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





class PayTypeView: UIView {
    var checkImageView: UIImageView!
    var imageView: UIImageView!
    var title: UILabel!
    
    var clickHandler: ((Int) -> Void)?
    var tap: UITapGestureRecognizer!
    var isChecked: Bool = false {
        willSet{
            if newValue {
                checkImageView.image = UIImage.init(named: "pay_checked")
            } else {
                checkImageView.image = UIImage.init(named: "pay_uncheck")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        checkImageView = UIImageView()
        checkImageView.userInteractionEnabled = true

        self.addSubview(checkImageView)
        
        checkImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self)
        }

        imageView = UIImageView()
        imageView.userInteractionEnabled = true
        self.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(checkImageView.snp_right).offset(8)
            make.width.height.equalTo(30)
            make.bottom.equalTo(checkImageView.snp_centerY)
        }
        
        title = UILabel()
        title.userInteractionEnabled = true
        title.font = UIFont.systemFontOfSize(14.0)
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp_bottom).offset(14)
        }
        
        tap = UITapGestureRecognizer.init(target: self, action: #selector(self.click))
        self.addGestureRecognizer(tap)
        self.userInteractionEnabled = true
    }
    
    func click() {
        self.clickHandler?(self.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
