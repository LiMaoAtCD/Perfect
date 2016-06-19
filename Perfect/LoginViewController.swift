//
//  LoginViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Async
import SVProgressHUD
import ChameleonFramework

class LoginNavigationController: UINavigationController {
    
}

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    var cellphoneTextfield: UITextField!
    var passwordTextfield: UITextField!
    var cellphoneLabel: UILabel!
    var passwordLabel: UILabel!
    var forgetpasswordButton: UIButton!
    var registerButton: UIButton!
    var loginButton: UIButton!
    
    var cellphone: String! = ""
    var password: String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        self.title = "登录"

        setupViews()
        
        
    }
    
    override func configurePopNavigationItem() {
        
        let image = UIImage(named: "ic_back")
        let backButton = UIButton(type: .Custom)
        backButton.setImage(image, forState: .Normal)
        backButton.frame = CGRectMake(0, 0, image!.size.width, image!.size.height)
        backButton.addTarget(self, action: #selector(self.dismiss), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func dismiss() {
        
        
        Defaults[.logined] = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        //背景
//        let imageview = UIImageView()
//        self.view.addSubview(imageview)
//        imageview.snp_makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
//        imageview.image = UIImage.init(named: "loginBg")
        
        //图标
//        let icon = UIImageView()
//        self.view.addSubview(icon)
//        icon.snp_makeConstraints { (make) in
//            make.centerX.equalTo(view)
//            make.width.height.equalTo(80)
//            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(100)
//        }
//        
//        icon.image = UIImage.init(named: "h6")
        
        
        
        //用户名
//        let nameImageView = UIImageView()
//        self.view.addSubview(nameImageView)
//        nameImageView.snp_makeConstraints { (make) in
//            make.left.equalTo(40)
//            make.width.height.equalTo(20)
//            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(20)
//        }
//        nameImageView.image = UIImage.init(named: "perfect")
        
        
        
        
        cellphoneLabel = UILabel()
        cellphoneLabel.text = "手机号码"
        cellphoneLabel.textColor = UIColor.blackColor()
        view.addSubview(cellphoneLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = "密码"
        passwordLabel.textColor = UIColor.blackColor()

        view.addSubview(passwordLabel)
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        cellphoneTextfield.placeholder = "请输入号码"
        cellphoneTextfield.keyboardType = .NumberPad
        view.addSubview(cellphoneTextfield)
        
        passwordTextfield = UITextField()
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
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
        loginButton.backgroundColor = UIColor.flatSandColor()
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(line0)
        line0.hidden = true
        
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
        
        if checkValidation() {
            SVProgressHUD.showWithStatus("")
            NetworkHelper.instance.request(.GET, url: URLConstant.memberLogin.contant, parameters: ["username": cellphone,"password": password], completion: { (result: LoginResponse?) in
                SVProgressHUD.showSuccessWithStatus("登录成功")
                Async.main(after: 1.0, block: {
                    
                    Defaults[.logined] = true
                    if Defaults[.shouldSwitch] {
                        let tab =  Tool.root.viewControllers.first as! RootTabBarController
                        tab.selectedIndex = 2
                        Defaults[.shouldSwitch] = false
                    }
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }) { (errMsg: String?, errCode: Int) in
                SVProgressHUD.showErrorWithStatus(errMsg ?? "登录失败")
            }
        }
    }
    
    func checkValidation()-> Bool {
        
        if !self.cellphone.isValidCellPhone {
            showAlertWithMessage("手机号码不合法", block: nil)
            return false
        }
        
        if password.isEmpty {
            showAlertWithMessage("密码不能为空", block: nil)
            return false
        }
        
        return true
    }
    
    //MARK: 输入框处理
    func textFieldDidEditChanged(textfield: UITextField) {
        //
        if textfield == cellphoneTextfield {
            cellphone = textfield.text
            
            let text = NSString(string: cellphone!)
            if text.length > 11 {
                textfield.text = text.substringToIndex(11)
                cellphone = textfield.text
            }
        } else {
            password = textfield.text
            let p = password as NSString
            if p.length > 16 {
                textfield.text = p.substringToIndex(16)
                password = textfield.text
            }
        }
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
