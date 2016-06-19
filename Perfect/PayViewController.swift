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
    
    var addressView: UIView!
    var goodView: UIView!
    var messageView: UIView!
    var priceView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView.init()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        //1地址
        
        addressView = UIView()
        scrollView.addSubview(addressView)
        
        addressView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(60)
        }
        
        let nameLabel = UILabel()
        addressView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(addressView).offset(8)
            make.top.equalTo(10)
            
        }
        nameLabel.text = "收货人:"
        
        let name = UILabel()
        addressView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right)
            make.centerY.equalTo(nameLabel)
        }
        
        name.text = "我"
        
        let cellphone = UILabel()
        addressView.addSubview(cellphone)
        cellphone.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right)
            make.right.equalTo(addressView).offset(-20)
            make.centerY.equalTo(nameLabel)
        }
        
        cellphone.text = "13411111111"
        
        
        let addressLabel = UILabel()
        addressView.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            
        }
        
        addressLabel.text = "详细地址"
        
        let address = UILabel()
        addressView.addSubview(address)
        address.snp_makeConstraints { (make) in
            make.left.equalTo(addressLabel.snp_right)
            make.centerY.equalTo(addressLabel)
        }
        
        address.text = "四川省成都市高新区"

        
        addressView.backgroundColor = UIColor.lightGrayColor()
        
        
        //2 商品
        goodView = UIView()
        
        scrollView.addSubview(goodView)
        goodView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(addressView.snp_bottom)
            make.height.equalTo(200)
        }
        
        let goodImageView = UIImageView()
        goodImageView.image = UIImage.init(named: "jiu")
        goodView.addSubview(goodImageView)
        goodImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.centerY.equalTo(goodView)
            make.left.equalTo(20)
        }
        
        let title = UILabel.init()
        title.text = "xxxx酒"
        goodView.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp_right).offset(20)
            make.top.equalTo(goodImageView)
        }
        
        let content = UILabel.init()
        content.text = "容量: 450ml 酒精度:52%vol"
        goodView.addSubview(content)
        content.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(title.snp_bottom)
        }
        
        let priceLabel = UILabel.init()
        priceLabel.text = "￥100"
        goodView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(content)
            make.top.equalTo(content.snp_bottom)
        }
        
        //3卖家留言
        messageView = UIView()
        scrollView.addSubview(messageView)
        messageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(120)
            make.top.equalTo(goodView.snp_bottom)
            
        }
        
        let leaveMessage = UILabel()
        leaveMessage.text = "给卖家留言"
        messageView.addSubview(leaveMessage)
        leaveMessage.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(8)
        }
        
        let textView = UITextView()
        messageView.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.top.equalTo(leaveMessage.snp_bottom)
            make.bottom.equalTo(messageView).offset(-8)
        }
        
        
        //4 价格
        
        priceView = UIView()
        scrollView.addSubview(priceView)
        priceView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(messageView.snp_bottom)
            make.height.equalTo(70)
        }
        
        let delivertotalPriceLabel = UILabel()
        priceView.addSubview(delivertotalPriceLabel)
        delivertotalPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(priceView)
        }
        
        delivertotalPriceLabel.text = "总运费"
        
        let deliverPrice = UILabel()
        deliverPrice.text = "￥5.00"
        priceView.addSubview(deliverPrice)
        deliverPrice.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(delivertotalPriceLabel)
        }
        
        
        let totalPriceLabel = UILabel()
        priceView.addSubview(totalPriceLabel)
        totalPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(delivertotalPriceLabel.snp_bottom)
        }
        
        totalPriceLabel.text = "实付款"
        
        let totalPrice = UILabel()
        totalPrice.text = "￥25.00"
        priceView.addSubview(totalPrice)
        totalPrice.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(totalPriceLabel)
        }
        
        //5 
        
        let submitView = UIView()
        submitView.backgroundColor = UIColor.grayColor()
        view.addSubview(submitView)
        
        submitView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(44)
        }
        
        
        let button = UIButton()
        button.setTitle("提交订单", forState: .Normal)
        button.backgroundColor = UIColor.brownColor()
        submitView.addSubview(button)
        
        button.snp_makeConstraints { (make) in
            make.center.equalTo(submitView)
            make.left.equalTo(8)
            make.top.equalTo(8)
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
