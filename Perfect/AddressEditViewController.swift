//
//  AddressEditViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/20.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class AddressEditViewController: BaseViewController {

    var scrollView: UIScrollView!
    var upperView: UIView!
    var finishedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "收货地址管理"
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(hexString: "#cccccc")
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        setupUpper()
        
        finishedButton = UIButton()
        scrollView.addSubview(finishedButton)
        finishedButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(50)
            make.top.equalTo(upperView.snp_bottom).offset(15)
        }
        finishedButton.backgroundColor = UIColor.whiteColor()
        finishedButton.setTitle("完成", forState: .Normal)
        finishedButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        finishedButton.addTarget(self, action: #selector(self.finishEdit), forControlEvents: .TouchUpInside)
        
    }
    
    func finishEdit() {
        
    }

    func setupUpper() {
        upperView = UIView()
        upperView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(upperView)
        upperView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(20)
            make.height.equalTo(300).priority(500)
        }
        
        let title0 = UILabel()
        title0.text = "收货人"
        upperView.addSubview(title0)
        title0.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(upperView).offset(20)
        }
        
        let nameTextfield = UITextField.init()
        upperView.addSubview(nameTextfield)
        nameTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(title0.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title0)
        }
        let line0 = UIView()
        line0.backgroundColor = UIColor(hexString: "#cccccc")
        upperView.addSubview(line0)
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50)
        }
        
        let title1 = UILabel()
        title1.text = "联系电话"
        upperView.addSubview(title1)
        title1.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(line0).offset(20)
        }
        
        let phoneTextfield = UITextField.init()
        upperView.addSubview(phoneTextfield)
        phoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(title1.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title1)
        }
        let line1 = UIView()
        line1.backgroundColor = UIColor(hexString: "#cccccc")

        upperView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50 * 2)
        }
        
        
        let title2 = UILabel()
        title2.text = "所在地区"
        upperView.addSubview(title2)
        title2.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(line1).offset(20)
        }
        
        let addressLabel = UILabel.init()
        upperView.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(title2.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title2)
        }
        let line2 = UIView()
        line2.backgroundColor = UIColor(hexString: "#cccccc")

        upperView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50 * 3)
        }
        
        let detailAddress = UITextView.init()
        upperView.addSubview(detailAddress)
        detailAddress.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(8)
            make.right.equalTo(upperView).offset(-8)
            make.top.equalTo(line2).offset(10)
            make.height.equalTo(100)
            make.bottom.equalTo(upperView.snp_bottom)
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
