//
//  LoginViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var cellphoneTextfield: UITextField!
    var passwordTextfield: UITextField!
    
    var cellphoneLabel: UILabel!
    var passwordLabel: UILabel!
    
    var forgetpasswordButton: UIButton!
    var registerButton: UIButton!
    
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        cellphoneLabel = UILabel()
        cellphoneLabel.text = "手机号码"
        cellphoneLabel.textColor = UIColor.blackColor()
        view.addSubview(cellphoneLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = "密码"
        passwordLabel.textColor = UIColor.blackColor()

        view.addSubview(passwordLabel)
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.delegate = self
        cellphoneTextfield.placeholder = "请输入号码"
        view.addSubview(cellphoneTextfield)
        
        passwordTextfield = UITextField()
        passwordTextfield.delegate = self
        passwordTextfield.placeholder = "请输入密码"
        view.addSubview(passwordTextfield)
        
        registerButton = UIButton.init(type: .Custom)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        registerButton.addTarget(self, action: #selector(self.register), forControlEvents: .TouchUpInside)
        view.addSubview(registerButton)
        
        forgetpasswordButton = UIButton.init(type: .Custom)
        forgetpasswordButton.setTitle("忘记密码？", forState: .Normal)
        forgetpasswordButton.setTitleColor(UIColor.brownColor(), forState: .Normal)

        forgetpasswordButton.addTarget(self, action: #selector(self.forget), forControlEvents: .TouchUpInside)
        view.addSubview(forgetpasswordButton)
        
        loginButton = UIButton.init(type: .Custom)
        loginButton.addTarget(self, action: #selector(self.login), forControlEvents: .TouchUpInside)
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.backgroundColor = UIColor.brownColor()
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line0)
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line1)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line2)
        
        
        
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
        
        passwordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(cellphoneLabel)
            make.centerY.equalTo(cellphoneLabel.snp_centerY).offset(60)
        }
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(passwordLabel.snp_right)
            make.centerY.equalTo(cellphoneTextfield).offset(60)
            make.right.equalTo(cellphoneTextfield)
            make.height.equalTo(cellphoneTextfield)
        }
        
        registerButton.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(100)
            make.height.equalTo(35)
            make.top.equalTo(line2).offset(20)
        }
        
        forgetpasswordButton.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(registerButton.snp_centerY)
            make.width.equalTo(100)
        }
        
        loginButton.snp_makeConstraints { (make) in
            make.top.equalTo(line2.snp_bottom).offset(60)
            make.centerX.equalTo(view)
            make.height.equalTo(45)
            make.left.equalTo(14)
        }
        
        
        
        
        
    }
    
    func register() {
        
        let registerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func forget() {
        let forgetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ForgetViewController") as! ForgetViewController
        
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }
    
    func login() {
        Defaults[.logined] = true
        if Defaults[.shouldSwitch] {
           let tab =  Tool.root.viewControllers.first as! RootTabBarController
            tab.selectedIndex = 1
            Defaults[.shouldSwitch] = false
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
