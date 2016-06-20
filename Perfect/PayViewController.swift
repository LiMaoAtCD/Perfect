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
    
    
    
    var buyerView: UIView!
    var nameLabel: UILabel!//收货人
    var contactLabel: UILabel!//联系电话
    var addressLabel: UILabel!//地址
    
    var customView: UIView!
    var customGoodImageView: UIImageView!//商品预览图
    
    var quantityView: UIStepper! //数量
    
    var priceView: UIView! // 价格
    
    
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
        scrollView.backgroundColor = UIColor.init(hexString: "#cccccc")
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
        mainView.backgroundColor = UIColor.whiteColor()
        customView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.right.equalTo(customView).offset(-14)
            make.top.equalTo(title.snp_bottom).offset(20)
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
        tipTitle.backgroundColor = UIColor.lightGrayColor()
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
        mainView.addSubview(changeButton)
        
        changeButton.snp_makeConstraints { (make) in
            make.right.equalTo(mainView).offset(-8)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.bottom.equalTo(mainView.snp_bottom).offset(-20)
        }

    }
    
    func custom() {
        let customVC = Tool.sb.instantiateViewControllerWithIdentifier("CustomGoodViewController") as! CustomGoodViewController
        self.navigationController?.pushViewController(customVC, animated: true)
    }
    
    func configureQuantityView() {
        quantityView = UIStepper.init()
        quantityView.addTarget(self, action: #selector(self.numberChanged), forControlEvents: .ValueChanged)
        quantityView.maximumValue = 999
        scrollView.addSubview(quantityView)
        quantityView.snp_makeConstraints { (make) in
            make.top.equalTo(customView.snp_bottom)
            make.left.right.equalTo(customView)
            make.height.equalTo(80)
        }
        
    }
    
    func numberChanged(id: UIStepper){
        print(id.value)
    }
    
    
    func configurePriceView() {
        priceView = UIView()
        scrollView.addSubview(priceView)
        priceView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(quantityView.snp_bottom)
            make.height.equalTo(100)
        }
    }
    
    func configureOrderButton() {
        let submit = UIButton.init(type: .Custom)
        self.scrollView.addSubview(submit)
        
        submit.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(45)
            make.top.equalTo(priceView.snp_bottom).offset(20)
            make.bottom.equalTo(scrollView)
        }
        
        submit.addTarget(self, action: #selector(self.submitOrder), forControlEvents: .TouchUpInside)
        submit.backgroundColor = UIColor.flatPinkColor()
        submit.layer.cornerRadius = 5
        submit.layer.masksToBounds = true
        

    }
    
    func submitOrder() {
        NetworkHelper.instance.request(.GET, url: URLConstant.appConfirmOrder.contant, parameters: ["productId":productId.toNSNumber,"quantity":quantity, "areaId": areaId.toNSNumber,"contactAddress": contactAddress, "contactName": contactName, "contactPhone": contactPhone, "customImgId": customImgId.toNSNumber, "payType":"alipay"], completion: { (result: ConfirmOrderResponse?) in
            
            }) { (errMsg, errCode) in
                
        }
    }
    
    func configurePayView() {
//        let payV
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScrollView()
        configureBuyerView()
        configureGoodView()
        configurePayView()
        
//
//        let goodImageView = UIImageView()
//        goodImageView.image = UIImage.init(named: "jiu")
//        goodView.addSubview(goodImageView)
//        goodImageView.snp_makeConstraints { (make) in
//            make.width.height.equalTo(40)
//            make.centerY.equalTo(goodView)
//            make.left.equalTo(20)
//        }
//        
//        let title = UILabel.init()
//        title.text = "xxxx酒"
//        goodView.addSubview(title)
//        title.snp_makeConstraints { (make) in
//            make.left.equalTo(goodImageView.snp_right).offset(20)
//            make.top.equalTo(goodImageView)
//        }
//        
//        let content = UILabel.init()
//        content.text = "容量: 450ml 酒精度:52%vol"
//        goodView.addSubview(content)
//        content.snp_makeConstraints { (make) in
//            make.left.equalTo(title)
//            make.top.equalTo(title.snp_bottom)
//        }
//        
//        let priceLabel = UILabel.init()
//        priceLabel.text = "￥100"
//        goodView.addSubview(priceLabel)
//        priceLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(content)
//            make.top.equalTo(content.snp_bottom)
//        }
//        
//        //3卖家留言
//        messageView = UIView()
//        scrollView.addSubview(messageView)
//        messageView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.height.equalTo(120)
//            make.top.equalTo(goodView.snp_bottom)
//            
//        }
//        
//        let leaveMessage = UILabel()
//        leaveMessage.text = "给卖家留言"
//        messageView.addSubview(leaveMessage)
//        leaveMessage.snp_makeConstraints { (make) in
//            make.left.equalTo(8)
//            make.top.equalTo(8)
//        }
//        
//        let textView = UITextView()
//        messageView.addSubview(textView)
//        textView.snp_makeConstraints { (make) in
//            make.left.equalTo(8)
//            make.right.equalTo(-8)
//            make.top.equalTo(leaveMessage.snp_bottom)
//            make.bottom.equalTo(messageView).offset(-8)
//        }
//        
//        
//        //4 价格
//        
//        priceView = UIView()
//        scrollView.addSubview(priceView)
//        priceView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.top.equalTo(messageView.snp_bottom)
//            make.height.equalTo(70)
//        }
//        
//        let delivertotalPriceLabel = UILabel()
//        priceView.addSubview(delivertotalPriceLabel)
//        delivertotalPriceLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(8)
//            make.top.equalTo(priceView)
//        }
//        
//        delivertotalPriceLabel.text = "总运费"
//        
//        let deliverPrice = UILabel()
//        deliverPrice.text = "￥5.00"
//        priceView.addSubview(deliverPrice)
//        deliverPrice.snp_makeConstraints { (make) in
//            make.right.equalTo(-8)
//            make.centerY.equalTo(delivertotalPriceLabel)
//        }
//        
//        
//        let totalPriceLabel = UILabel()
//        priceView.addSubview(totalPriceLabel)
//        totalPriceLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(8)
//            make.top.equalTo(delivertotalPriceLabel.snp_bottom)
//        }
//        
//        totalPriceLabel.text = "实付款"
//        
//        let totalPrice = UILabel()
//        totalPrice.text = "￥25.00"
//        priceView.addSubview(totalPrice)
//        totalPrice.snp_makeConstraints { (make) in
//            make.right.equalTo(-8)
//            make.centerY.equalTo(totalPriceLabel)
//        }
//        
//        //5 
//        
//        let submitView = UIView()
//        submitView.backgroundColor = UIColor.grayColor()
//        view.addSubview(submitView)
//        
//        submitView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.bottom.equalTo(view)
//            make.height.equalTo(44)
//        }
//
//        
//
        
        
        
        
        

        
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

extension Int64 {
    var toNSNumber: NSNumber {
        return NSNumber.init(longLong: self)
    }
}
