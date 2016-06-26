//
//  PayViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class PayViewController: BaseViewController {

    var scrollView: UIScrollView!
    
    var buyerView: UIView! //顶部信息
    var nameLabel: UILabel!//收货人
    var contactLabel: UILabel!//联系电话
    var addressLabel: UILabel!//地址
    
    //定制信息
    var customView: UIView!
    var priceView: UIView! // 价格
    
    //支付信息
    var payTypeViews: [PayTypeView]!
    
    //底部合计
    var bottomView: UIView!
    var totalPriceLabel = UILabel()

    
    var productId: Int64 = 0
    var quantity: Int = 0
    var areaId: Int64 = -1
    var contactAddress = ""
    var contactName = ""
    var contactPhone = ""
    var customImgId: Int64 = 0
    var payType: String = ""
    
    
    func configureScrollView() {
        scrollView = UIScrollView.init()
        scrollView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-50)
        }
    }
    
    func configureBuyerView() {
        buyerView = UIView()
        buyerView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(buyerView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.changeAddress))
        buyerView.addGestureRecognizer(tap)
        
        let titleLabel = UILabel()
        buyerView.addSubview(titleLabel)
        titleLabel.text = "收货地址"
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(buyerView).offset(14)
            make.top.equalTo(buyerView).offset(8)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        nameLabel = UILabel()
        buyerView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_right).offset(20)
            make.centerY.equalTo(titleLabel)
        }
        nameLabel.textColor = UIColor.lightGrayColor()
        nameLabel.text = "张一山"
        nameLabel.font = UIFont.systemFontOfSize(14)

        contactLabel = UILabel()
        buyerView.addSubview(contactLabel)
        contactLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right).offset(8)
            make.centerY.equalTo(nameLabel)
        }
        contactLabel.text = "14311111111"
    
        
        addressLabel = UILabel()
        addressLabel.text = "四川省成都市武侯区跪下了的骄傲付款了就发离开家地方"
        addressLabel.numberOfLines = 0
        buyerView.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel).offset(8)
            make.top.equalTo(nameLabel.snp_bottom).offset(15)
            make.right.equalTo(buyerView.snp_right).offset(-20)
        }
        
        buyerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(20)
            make.height.equalTo(100)
        }

        let flagImageView = UIImageView()
        flagImageView.image = UIImage.init(named: "fourtag")
        buyerView.addSubview(flagImageView)
        flagImageView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(buyerView)
            make.height.equalTo(10)
        }
    }
    
    func configureGoodView() {
        customView = UIView()
        customView.backgroundColor = UIColor.clearColor()
        
        scrollView.addSubview(customView)
        
        customView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(buyerView.snp_bottom)
        }
        
        let title = UILabel()
        title.text = "订单商品"
        title.textColor = UIColor.blackColor()
        title.font = UIFont.systemFontOfSize(16)
        customView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(customView).offset(14)
            make.top.equalTo(customView).offset(8)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        let mainView = UIView()
        customView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(customView).offset(-14)
            make.top.equalTo(title.snp_bottom).offset(20)
            make.bottom.equalTo(customView).offset(-8)
        }
        
        let previewImageview = UIImageView()
        previewImageview.image = UIImage.init(named: "customEffect")
        mainView.addSubview(previewImageview)
        previewImageview.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.width.height.equalTo(80)
            make.top.equalTo(8)
        }
        
        let goodsTitle = UILabel.init()
        goodsTitle.numberOfLines = 0
        goodsTitle.textColor = UIColor.blackColor()
        goodsTitle.font = UIFont.systemFontOfSize(14.0)
        mainView.addSubview(goodsTitle)
        goodsTitle.snp_makeConstraints { (make) in
            make.left.equalTo(previewImageview.snp_right).offset(8)
            make.right.equalTo(mainView).offset(-14)
            make.top.equalTo(previewImageview)
        }
        goodsTitle.text = "飞天毛衣他空间打客服哈卡积分换发客服哈就开发好"
        
        let priceLabel = UILabel()
        let price: NSString = "￥1000"
        let attributeString = NSMutableAttributedString.init(string: "￥1000", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10)], range: NSMakeRange(0, 1))
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(18)], range: NSMakeRange(1, price.length - 1))
        priceLabel.attributedText = attributeString
        mainView.addSubview(priceLabel)
        
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodsTitle)
            make.width.equalTo(50)
            make.bottom.equalTo(previewImageview)
            make.height.equalTo(30)
        }
        
        let marginView = UIView()
        marginView.backgroundColor = UIColor.lightGrayColor()
        
        mainView.addSubview(marginView)
        marginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.height.equalTo(0.3)
            make.top.equalTo(previewImageview.snp_bottom).offset(8)
        }
        
        let myGoodImageView = UIImageView()
        mainView.addSubview(myGoodImageView)
        myGoodImageView.image = UIImage.init(named: "customEffect")
        
        myGoodImageView.snp_makeConstraints { (make) in
            make.left.equalTo(previewImageview)
            make.width.height.equalTo(previewImageview)
            make.top.equalTo(marginView).offset(8)
            make.bottom.equalTo(mainView).offset(-8)
        }
        
        let tipTitle = UILabel()
        tipTitle.text = "左图为定制图案"
        mainView.addSubview(tipTitle)
        tipTitle.snp_makeConstraints { (make) in
            make.left.equalTo(myGoodImageView.snp_right).offset(8)
            make.top.equalTo(marginView).offset(20)
        }
        

        
        let changeButton = UIButton.init()
        changeButton.backgroundColor = UIColor.redColor()
        changeButton.setTitle("更换定制图", forState: .Normal)
        changeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changeButton.addTarget(self, action: #selector(self.custom), forControlEvents: .TouchUpInside)
        mainView.addSubview(changeButton)
        
        changeButton.snp_makeConstraints { (make) in
            make.right.equalTo(mainView).offset(-8)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.bottom.equalTo(mainView.snp_bottom).offset(-20)
        }

    }
    
    
    func configurePayView() {
        let payView = UIView()
        payView.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(payView)
        payView.snp_makeConstraints { (make) in
            make.left.right.equalTo(customView)
            make.top.equalTo(customView.snp_bottom).offset(20)
        }
        
        
        let title = UILabel()
        title.text = "支付方式"
        title.font = UIFont.systemFontOfSize(16.0)
        title.textColor = UIColor.blackColor()
        payView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(payView).offset(14)
            make.top.equalTo(payView).offset(8)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        let mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        payView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(customView).offset(-14)
            make.top.equalTo(title.snp_bottom).offset(20)
        }
        
        let payItemMargin: CGFloat = 20
        let payItemWidth = ((Tool.width - 2 * 14) - 4 * payItemMargin) / 3
        payTypeViews = [PayTypeView]()
        for i in 0...2 {
            let payitemView = PayTypeView.init(frame: CGRectZero)
            payitemView.tag = i
            mainView.addSubview(payitemView)
            payitemView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(payItemMargin + (payItemWidth + payItemMargin) * CGFloat(i))
                make.width.equalTo(payItemWidth)
                make.height.equalTo(60)
                make.top.equalTo(mainView).offset(14)
                make.bottom.equalTo(mainView.snp_bottom).offset(-20)
            })
            payTypeViews.append(payitemView)
            if i == 0 {
                payitemView.imageView.image = UIImage.init(named: "")
                payitemView.title.text = "支付宝"
            } else if i == 1 {
                payitemView.imageView.image = UIImage.init(named: "")
                payitemView.title.text = "微信"

            } else {
                payitemView.imageView.image = UIImage.init(named: "")
                payitemView.title.text = "线下支付"
            }
        }
        
        
        
    }
    
    func configureTotalView() {
        bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.top.equalTo(scrollView.snp_bottom)
        }
        
        let settleButton = UIButton()
        bottomView.addSubview(settleButton)
        settleButton.snp_makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.height.top.equalTo(bottomView)
        }
        settleButton.backgroundColor = UIColor.redColor()
        settleButton.setTitle("结算", forState: .Normal)
        settleButton.addTarget(self, action: #selector(self.submitOrder), forControlEvents: .TouchUpInside)
        
        totalPriceLabel = UILabel()
        let totalPrice: NSString = "￥1000"
        let attributeString = NSMutableAttributedString.init(string: "￥1000", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10)], range: NSMakeRange(0, 1))
        attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(18)], range: NSMakeRange(1, totalPrice.length - 1))
        totalPriceLabel.attributedText = attributeString
        bottomView.addSubview(totalPriceLabel)
        totalPriceLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(settleButton)
            make.right.equalTo(settleButton.snp_left).offset(-10)
            make.height.equalTo(bottomView)
            make.width.lessThanOrEqualTo(150).priority(250)
        }
        
        
        let title = UILabel()
        bottomView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.right.equalTo(totalPriceLabel.snp_left)
            make.centerY.equalTo(settleButton)
            make.baseline.equalTo(totalPriceLabel)
        }
        title.text = "合计:"
    }
    
    func changeAddress() {
        let addressVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddressViewController") as! AddressViewController
        addressVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    func custom() {
        let customVC = Tool.sb.instantiateViewControllerWithIdentifier("CustomGoodViewController") as! CustomGoodViewController
        self.navigationController?.pushViewController(customVC, animated: true)
    }
    
    func submitOrder() {
        NetworkHelper.instance.request(.GET, url: URLConstant.appConfirmOrder.contant, parameters: ["productId":productId.toNSNumber,"quantity":quantity, "areaId": areaId.toNSNumber,"contactAddress": contactAddress, "contactName": contactName, "contactPhone": contactPhone, "customImgId": customImgId.toNSNumber, "payType":"alipay"], completion: { (result: ConfirmOrderResponse?) in
            
            }) { (errMsg, errCode) in
                
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScrollView()
        configureBuyerView()
        configureGoodView()
        configurePayView()
        configureTotalView()
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



class PayTypeView: UIView {
    var checkImageView: UIImageView!
    var imageView: UIImageView!
    var title: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        checkImageView = UIImageView()
        self.addSubview(checkImageView)
        
        checkImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self)
        }

        imageView = UIImageView()
        self.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(checkImageView.snp_right).offset(8)
            make.width.height.equalTo(30)
            make.bottom.equalTo(checkImageView.snp_centerY)
        }
        
        title = UILabel()
        self.addSubview(title)
        
        title.snp_makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp_bottom).offset(14)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
