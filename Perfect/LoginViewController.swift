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
        self.title = "登录"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.lightGrayColor()]

        setupViews()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        self.cellphoneTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        super.viewWillAppear(animated)
    }
    
    override func configurePopNavigationItem() {
        
        let image = UIImage(named: "navi_back")
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
        let imageview = UIImageView()
        self.view.addSubview(imageview)
        imageview.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        imageview.image = UIImage.init(named: "login_bg")
        
        //app图标
        let icon = UIImageView()
        self.view.addSubview(icon)
        icon.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.height.equalTo(168.pixelToPoint)
            make.bottom.equalTo(self.snp_topLayoutGuideTop).offset(430.pixelToPoint)
        }
        
        icon.image = UIImage.init(named: "login_logo")
        
        
        let userTagImageView = UIImageView()
        userTagImageView.image = UIImage.init(named: "login_user")
        view.addSubview(userTagImageView)
        userTagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(88.pixelToPoint)
            make.width.height.equalTo(43.pixelToPoint)
            make.top.equalTo(icon.snp_bottom).offset(180.pixelToPoint)
        }
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        cellphoneTextfield.attributedPlaceholder = NSAttributedString.init(string: "手机号", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7)])
        cellphoneTextfield.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)
        cellphoneTextfield.keyboardType = .NumberPad
        view.addSubview(cellphoneTextfield)
        
        cellphoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(userTagImageView.snp_right).offset(40.pixelToPoint)
            make.centerY.equalTo(userTagImageView)
            make.right.equalTo(-40.pixelToPoint)
            make.height.equalTo(125.pixelToPoint)
        }
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.init(hexString: "#bcbabb", withAlpha: 0.7)
        view.addSubview(line0)
        
        line0.snp_makeConstraints { (make) in
            make.left.equalTo(38.pixelToPoint)
            make.right.equalTo(-38.pixelToPoint)
            make.top.equalTo(userTagImageView.snp_bottom).offset(31.pixelToPoint)
            make.height.equalTo(1.pixelToPoint)
        }
        
        let lockTagImageview = UIImageView()
        lockTagImageview.image = UIImage.init(named: "login_lock")
        view.addSubview(lockTagImageview)
        lockTagImageview.snp_makeConstraints { (make) in
            make.left.equalTo(userTagImageView)
            make.width.height.equalTo(userTagImageView)
            make.top.equalTo(userTagImageView).offset(125.pixelToPoint)
        }
        
        passwordTextfield = UITextField()
        passwordTextfield.secureTextEntry = true
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.attributedPlaceholder = NSAttributedString.init(string: "密码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7)])
        passwordTextfield.textColor = UIColor.whiteColor()
        view.addSubview(passwordTextfield)
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(cellphoneTextfield)
            make.centerY.equalTo(lockTagImageview)
        }
        let line1 = UIView()
        line1.backgroundColor = UIColor.init(hexString: "#bcbabb", withAlpha: 0.7)
        view.addSubview(line1)
        
        line1.snp_makeConstraints { (make) in
            make.left.height.right.equalTo(line0)
            make.top.equalTo(line0.snp_bottom).offset(125.pixelToPoint)
        }
        
        loginButton = UIButton.init(type: .Custom)
        loginButton.addTarget(self, action: #selector(self.login), forControlEvents: .TouchUpInside)
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setBackgroundImage(UIImage.init(named: "login_button_0"), forState: .Normal)
        loginButton.setBackgroundImage(UIImage.init(named: "login_button_1"), forState: .Highlighted)

        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        
        
        loginButton.snp_makeConstraints { (make) in
            make.top.equalTo(line1.snp_bottom).offset(124.pixelToPoint)
            make.height.equalTo(106.pixelToPoint)
            make.left.right.equalTo(line0)
        }
        
        registerButton = UIButton.init(type: .Custom)
        registerButton.addTarget(self, action: #selector(self.register), forControlEvents: .TouchUpInside)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.setBackgroundImage(UIImage.init(named: "login_register_0"), forState: .Normal)
        registerButton.setBackgroundImage(UIImage.init(named: "login_register_1"), forState: .Highlighted)
        registerButton.layer.cornerRadius = 10.0
        registerButton.layer.masksToBounds = true
        registerButton.layer.borderColor = UIColor.whiteColor().CGColor
        registerButton.layer.borderWidth = 1.0
        view.addSubview(registerButton)
        
        registerButton.snp_makeConstraints { (make) in
            make.left.height.right.equalTo(loginButton)
            make.top.equalTo(loginButton.snp_bottom).offset(21.pixelToPoint)
        }
        
        
        forgetpasswordButton = UIButton.init(type: .Custom)
        forgetpasswordButton.setTitle("忘记密码", forState: .Normal)
        forgetpasswordButton.setTitleColor(UIColor.init(hexString: "#fefefe", withAlpha: 0.7), forState: .Normal)
        forgetpasswordButton.addTarget(self, action: #selector(self.forget), forControlEvents: .TouchUpInside)
        view.addSubview(forgetpasswordButton)
        forgetpasswordButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(loginButton)
            make.width.equalTo(100)
            make.top.equalTo(registerButton.snp_bottom).offset(73.pixelToPoint)
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
            SVProgressHUD.show()
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


