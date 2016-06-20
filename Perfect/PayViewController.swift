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
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func configureBuyerView() {
        buyerView = UIView()
        scrollView.addSubview(buyerView)
        
        let nameTitleLabel = UILabel()
        buyerView.addSubview(nameTitleLabel)
        nameTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(buyerView).offset(8)
            make.top.equalTo(10)
            
        }
        nameTitleLabel.text = "收货人:"

        nameLabel = UILabel()
        buyerView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel.snp_right)
            make.centerY.equalTo(nameTitleLabel)
        }

        let contactTitleLabel = UILabel()
        buyerView.addSubview(contactTitleLabel)
        contactTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(buyerView).offset(8)
            make.top.equalTo(nameTitleLabel.snp_bottom).offset(8)
        }
        contactTitleLabel.text = "联系电话:"
        
        contactLabel = UILabel()
        buyerView.addSubview(contactLabel)
        contactLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contactTitleLabel.snp_right).offset(8)
            make.centerY.equalTo(contactTitleLabel)
        }
        
        let addressTitleLabel = UILabel()
        buyerView.addSubview(addressTitleLabel)
        addressTitleLabel.text = "详细地址:"
        addressTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(buyerView).offset(8)
            make.top.equalTo(contactTitleLabel.snp_bottom).offset(8)
            
        }
        
        addressLabel = UILabel()
        buyerView.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(addressTitleLabel.snp_right).offset(8)
            make.centerY.equalTo(contactTitleLabel)
            make.bottom.equalTo(buyerView.snp_bottom).offset(-8)
        }
        
        buyerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView)
        }

    }
    
    func configureGoodView() {
        customView = UIView()
        
        scrollView.addSubview(customView)
        customView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(buyerView.snp_bottom)
            make.height.equalTo(customView.snp_width).multipliedBy(0.5)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.custom))
        customView.addGestureRecognizer(tap)
        customGoodImageView = UIImageView()
        customView.addSubview(customGoodImageView)
        customGoodImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(customView)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScrollView()
        configureBuyerView()
        configureGoodView()
        configureQuantityView()
        configurePriceView()
        configureOrderButton()
        
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
