//
//  RegisterViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var cellphoneLabel: UILabel!
    var verifyCodeLabel: UILabel!
    var passwordLabel: UILabel!
    var verifyButton: UIButton!
    var cellphoneTextfield: UITextField!
    var verifyTextField: UITextField!
    var passwordTextfield: UITextField!
    var registerButton: UIButton!
    var protocolButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        cellphoneLabel = UILabel()
        cellphoneLabel.text = "手机号码"
        cellphoneLabel.textColor = UIColor.blackColor()
        view.addSubview(cellphoneLabel)
        
        verifyCodeLabel = UILabel()
        verifyCodeLabel.text = "验证码"
        verifyCodeLabel.textColor = UIColor.blackColor()
        view.addSubview(verifyCodeLabel)

        passwordLabel = UILabel()
        passwordLabel.text = "密码"
        passwordLabel.textColor = UIColor.blackColor()
        
        view.addSubview(passwordLabel)
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.delegate = self
        cellphoneTextfield.placeholder = "请输入号码"
        view.addSubview(cellphoneTextfield)
        
        verifyTextField = UITextField()
        verifyTextField.delegate = self
        verifyTextField.placeholder = "请输入验证码"
        view.addSubview(verifyTextField)
        
        passwordTextfield = UITextField()
        passwordTextfield.delegate = self
        passwordTextfield.placeholder = "请设定密码"
        view.addSubview(passwordTextfield)
        
        verifyButton = UIButton.init(type: .Custom)
        verifyButton.setTitle("验证", forState: .Normal)
        verifyButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        verifyButton.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        view.addSubview(verifyButton)
        
        protocolButton = UIButton.init(type: .Custom)
        protocolButton.setTitle("《APP使用协议》", forState: .Normal)
        protocolButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        
        protocolButton.addTarget(self, action: #selector(self.protocolClick), forControlEvents: .TouchUpInside)
        view.addSubview(protocolButton)
        
        registerButton = UIButton.init(type: .Custom)
        registerButton.addTarget(self, action: #selector(self.register), forControlEvents: .TouchUpInside)
        registerButton.setTitle("同意协议并注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.backgroundColor = UIColor.brownColor()
        registerButton.layer.cornerRadius = 3.0
        registerButton.layer.masksToBounds = true
        view.addSubview(registerButton)
        
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line0)
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line1)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line2)
        
        let line3 = UIView()
        line3.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line3)
        
        
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(10)
            make.height.equalTo(1)
        }
        
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(line0.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(line1.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        line3.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(line2.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        cellphoneLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(line0.snp_bottom).offset(30)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        cellphoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(cellphoneLabel.snp_right).offset(0)
            make.centerY.equalTo(cellphoneLabel)
            make.right.equalTo(-50)
            make.height.equalTo(35)
        }
        
        verifyButton.snp_makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(cellphoneTextfield.snp_centerY)
            make.width.equalTo(60)
        }
        
        verifyCodeLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(cellphoneLabel)
            make.centerY.equalTo(cellphoneLabel).offset(60)
        }
        verifyTextField.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(cellphoneTextfield)
            make.centerY.equalTo(verifyCodeLabel)
        }
        
        passwordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(cellphoneLabel)
            make.centerY.equalTo(verifyCodeLabel.snp_centerY).offset(60)
        }
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(passwordLabel.snp_right)
            make.centerY.equalTo(verifyTextField).offset(60)
            make.right.equalTo(verifyTextField)
            make.height.equalTo(verifyTextField)
        }
    
        registerButton.snp_makeConstraints { (make) in
            make.top.equalTo(line3.snp_bottom).offset(60)
            make.centerX.equalTo(view)
            make.height.equalTo(45)
            make.left.equalTo(14)
        }
        
        protocolButton.snp_makeConstraints { (make) in
            make.top.equalTo(registerButton.snp_bottom).offset(60)
            make.centerX.equalTo(view)
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
    }
    
    func register() {
        
    }
    
    func verify() {
        
    }
    
    func protocolClick() -> Void {
        let proto = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProtocolViewController") as! ProtocolViewController
        
        self.navigationController?.pushViewController(proto, animated: true)

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
