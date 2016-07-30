//
//  RegisterViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ChameleonFramework
import SVProgressHUD
import SwiftyUserDefaults
import Async

class RegisterViewController: BaseViewController, UITextFieldDelegate {

    var verifyButton: UIButton!
    var cellphoneTextfield: UITextField!
    var verifyTextField: UITextField!
    var passwordTextfield: UITextField!
    var registerButton: UIButton!
    var protocolCheckButton: UIButton!
    var protocolLabel: UILabel!
    var personalButton: UIButton!
    var enterPriseButton: UIButton!
    
    var activeField: UITextField!
    
    var timer: NSTimer?
    var timerCount: Int = 60
    
    var cellphone: String! = ""
    var validCode: String! = ""
    var password: String! = ""
    var userProtocolChecked: Bool = false
    var personalRegister: Bool = true
    
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "注册"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //背景
        let imageview = UIImageView()
        self.view.addSubview(imageview)
        imageview.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        imageview.image = UIImage.init(named: "login_bg")
        
        
        scrollView = UIScrollView.init()
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clearColor()
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        setupViews()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func dismissKeyboard() {
        self.cellphoneTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
        self.verifyTextField.resignFirstResponder()
        activeField = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        super.viewWillAppear(animated)
    }
    
    func setupViews() {
        //图标
        let icon = UIImageView()
        icon.image = UIImage.init(named: "icon")
        scrollView.addSubview(icon)
        icon.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.height.equalTo(168.pixelToPoint)
            make.bottom.equalTo(scrollView.snp_top).offset(430.pixelToPoint)
        }
        
        let userTagImageView = UIImageView()
        userTagImageView.image = UIImage.init(named: "login_user")
        scrollView.addSubview(userTagImageView)
        userTagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(64.pixelToPoint)
            make.width.height.equalTo(43.pixelToPoint)
            make.top.equalTo(icon.snp_bottom).offset(180.pixelToPoint)
        }
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        cellphoneTextfield.attributedPlaceholder = NSAttributedString.init(string: "手机号", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7),NSFontAttributeName: UIFont.systemFontOfSize(14)])
        cellphoneTextfield.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)
        cellphoneTextfield.keyboardType = .NumberPad
        cellphoneTextfield.delegate = self
        scrollView.addSubview(cellphoneTextfield)
        
        cellphoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(userTagImageView.snp_right).offset(40.pixelToPoint)
            make.centerY.equalTo(userTagImageView)
            make.right.equalTo(view).offset(-40.pixelToPoint)
            make.height.equalTo(125.pixelToPoint)
        }
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.init(hexString: "#bcbabb", withAlpha: 0.7)
        scrollView.addSubview(line0)
        
        line0.snp_makeConstraints { (make) in
            make.left.equalTo(38.pixelToPoint)
            make.right.equalTo(view).offset(-38.pixelToPoint)
            make.top.equalTo(userTagImageView.snp_bottom).offset(31.pixelToPoint)
            make.height.equalTo(1.pixelToPoint)
        }

        let passwordTagImageView = UIImageView()
        passwordTagImageView.image = UIImage.init(named: "login_lock")
        scrollView.addSubview(passwordTagImageView)
        passwordTagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(userTagImageView)
            make.width.height.equalTo(userTagImageView)
            make.top.equalTo(userTagImageView).offset(125.pixelToPoint)
        }

        passwordTextfield = UITextField()
        passwordTextfield.attributedPlaceholder = NSAttributedString.init(string: "密码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7),NSFontAttributeName: UIFont.systemFontOfSize(14)])
        passwordTextfield.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)

        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.secureTextEntry = true
        passwordTextfield.delegate = self
        scrollView.addSubview(passwordTextfield)
        
        
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(cellphoneTextfield)
            make.centerY.equalTo(passwordTagImageView)
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.init(hexString: "#bcbabb", withAlpha: 0.7)
        scrollView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(line0)
            make.centerY.equalTo(line0.snp_centerY).offset(126.pixelToPoint)
        }
        
        let verifyTagImageView = UIImageView()
        verifyTagImageView.image = UIImage.init(named: "register_verify")
        scrollView.addSubview(verifyTagImageView)
        verifyTagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(userTagImageView)
            make.width.height.equalTo(43.pixelToPoint)
            make.centerY.equalTo(passwordTagImageView.snp_centerY).offset(126.pixelToPoint)
        }
        
        verifyTextField = UITextField()
        verifyTextField.delegate = self
        verifyTextField.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        verifyTextField.attributedPlaceholder = NSAttributedString.init(string: "验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7), NSFontAttributeName: UIFont.systemFontOfSize(14)])
        verifyTextField.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)
        verifyTextField.keyboardType = .Default
        verifyTextField.returnKeyType = .Go

        scrollView.addSubview(verifyTextField)
        
      
        
        verifyButton = UIButton.init(type: .Custom)
        verifyButton.setAttributedTitle(NSAttributedString(string: "获取验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fefefe", withAlpha: 0.7) ,NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)

        verifyButton.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        scrollView.addSubview(verifyButton)
        verifyButton.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(0)
            make.centerY.equalTo(verifyTextField.snp_centerY)
            make.width.equalTo(242.pixelToPoint)
        }
        verifyTextField.snp_makeConstraints { (make) in
            make.left.height.equalTo(cellphoneTextfield)
            make.centerY.equalTo(passwordTextfield).offset(126.pixelToPoint)
            make.right.equalTo(verifyButton.snp_left)
        }
        
        let marginView = UIView()
        scrollView.addSubview(marginView)
        marginView.backgroundColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)
        marginView.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-242.pixelToPoint)
            make.width.equalTo(1.pixelToPoint)
            make.height.equalTo(30)
            make.centerY.equalTo(verifyButton)
        }

        let line2 = UIView()
        line2.backgroundColor = UIColor.init(hexString: "#bcbabb", withAlpha: 0.7)
        scrollView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(line0)
            make.top.equalTo(line1.snp_bottom).offset(126.pixelToPoint)
        }
        
        protocolCheckButton = UIButton.init(type: .Custom)
        protocolCheckButton.addTarget(self, action: #selector(self.checkProtocol), forControlEvents: .TouchUpInside)
        protocolCheckButton.setImage(UIImage.init(named: "register_uncheck"), forState: .Normal)
        scrollView.addSubview(protocolCheckButton)
        protocolCheckButton.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(64.pixelToPoint)
            make.width.height.equalTo(33.pixelToPoint)
            make.top.equalTo(line2.snp_bottom).offset(52.pixelToPoint)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.gotoProtocol))
        protocolLabel = UILabel()
        let agree: NSString = "同意注册协议"
        let attributeString = NSMutableAttributedString.init(string: "同意注册协议", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        attributeString.addAttributes([NSForegroundColorAttributeName:
            UIColor.init(hexString: "#fefefe", withAlpha: 0.7),NSFontAttributeName: UIFont.systemFontOfSize(14)],
                                      range: NSMakeRange(0, 2))
        attributeString.addAttributes([NSForegroundColorAttributeName:
            UIColor.init(hexString: "#66b389", withAlpha: 0.7),NSFontAttributeName: UIFont.systemFontOfSize(14)],
                                      range: NSMakeRange(2, agree.length - 2))
        protocolLabel.attributedText = attributeString

        protocolLabel.addGestureRecognizer(tap)
        protocolLabel.userInteractionEnabled = true
        scrollView.addSubview(protocolLabel)
        protocolLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(protocolCheckButton)
            make.left.equalTo(protocolCheckButton.snp_right).offset(10)
        }
        
        let enterpriseLabel = UILabel()
        enterpriseLabel.text = "企业"
        enterpriseLabel.font =  UIFont.systemFontOfSize(12)
        enterpriseLabel.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)
        scrollView.addSubview(enterpriseLabel)
        enterpriseLabel.snp_makeConstraints { (make) in
            make.right.equalTo(line2.snp_right)
            make.centerY.equalTo(protocolCheckButton)
        }
        
        enterPriseButton = UIButton.init(type: .Custom)
        enterPriseButton.addTarget(self, action: #selector(self.choosePersonalOrEnterprise), forControlEvents: .TouchUpInside)
        enterPriseButton.setImage(UIImage.init(named: "register_uncheck"), forState: .Normal)
        scrollView.addSubview(enterPriseButton)
        enterPriseButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(protocolCheckButton)
            make.right.equalTo(enterpriseLabel.snp_left).offset(-8)
            make.centerY.equalTo(enterpriseLabel)
        }
        
        let personalLabel = UILabel()
        personalLabel.text = " 个人  /"
        personalLabel.font =  UIFont.systemFontOfSize(12)
        personalLabel.textColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7)

        scrollView.addSubview(personalLabel)
        personalLabel.snp_makeConstraints { (make) in
            make.right.equalTo(enterPriseButton.snp_left).offset(-8)
            make.centerY.equalTo(enterPriseButton)
        }
        
        personalButton = UIButton.init(type: .Custom)
        personalButton.addTarget(self, action: #selector(self.choosePersonalOrEnterprise), forControlEvents: .TouchUpInside)

        personalButton.setImage(UIImage.init(named: "register_checked"), forState: .Normal)
        scrollView.addSubview(personalButton)
        personalButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(enterPriseButton)
            make.centerY.equalTo(enterPriseButton)
            make.right.equalTo(personalLabel.snp_left).offset(-8)
        }
        
        
        registerButton = UIButton.init(type: .Custom)
        registerButton.addTarget(self, action: #selector(self.register), forControlEvents: .TouchUpInside)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.setBackgroundImage(UIImage.init(named: "login_register_0"), forState: .Normal)
        registerButton.setBackgroundImage(UIImage.init(named: "login_register_1"), forState: .Highlighted)
        registerButton.layer.cornerRadius = 10.0
        registerButton.layer.masksToBounds = true
        registerButton.layer.borderWidth = 1.pixelToPoint
        registerButton.layer.borderColor = UIColor.init(hexString: "#fefefe", withAlpha: 0.7).CGColor
        scrollView.addSubview(registerButton)

        registerButton.snp_makeConstraints { (make) in
            make.top.equalTo(protocolCheckButton.snp_bottom).offset(90.pixelToPoint)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(106.pixelToPoint)
            make.left.equalTo(39.pixelToPoint)
        }
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        activeField = textField
        return true
    }
    

    
    
    
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
        
        var aRect = self.view.frame
        aRect.size.height -= keyboardFrame.size.height
        if let _ = activeField {
            let point = CGPointMake(0, activeField.y - keyboardFrame.size.height)
            scrollView.setContentOffset(point, animated: true)
        }
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInset
    }
    
    //MARK: 注册
    func register() {
        if checkValidation() {
            SVProgressHUD.showWithStatus("注册中")
            NetworkHelper.instance.request(.GET, url: URLConstant.Register.contant, parameters: ["username": cellphone,"password": password, "validCode": validCode, "phone": cellphone, "type": (personalRegister ? "person" : "company")], completion: { (result: RegisterResponse?) in
                    Defaults[.password] = self.password
                    SVProgressHUD.showSuccessWithStatus("注册成功")
                    Async.main(after: 1.0, block: { 
//                        self.navigationController?.popViewControllerAnimated(true)
                        Util.logined = true
                        let switchTo = Defaults[.shouldSwitch]
                        if switchTo == 1 {
                            let tab =  Tool.root.viewControllers.first as! RootTabBarController
                            tab.selectedIndex = 2
                            Defaults[.shouldSwitch] = 0
                            self.dismissViewControllerAnimated(true, completion: nil)
                            return
                        } else if switchTo == 2 {
                            let tab =  Tool.root.viewControllers.first as! RootTabBarController
                            tab.selectedIndex = 1
                            Defaults[.shouldSwitch] = 0
                            self.dismissViewControllerAnimated(true, completion: nil)
                            return
                        } else {
                            Defaults[.shouldSwitch] = 0
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }

                    })
                }, failed: { (errMsg: String?, errCode: Int) in
                    SVProgressHUD.showErrorWithStatus(errMsg ?? "注册失败")
            })
        }
    }
    
    func checkProtocol() {
        if userProtocolChecked {
            userProtocolChecked = false
            protocolCheckButton.setImage(UIImage.init(named: "register_uncheck"), forState: .Normal)
        } else {
            userProtocolChecked = true
            protocolCheckButton.setImage(UIImage.init(named: "register_checked"), forState: .Normal)
        }
    }
    
    func choosePersonalOrEnterprise() {
        if personalRegister {
            personalRegister = false
            enterPriseButton.setImage(UIImage.init(named: "register_checked"), forState: .Normal)
            personalButton.setImage(UIImage.init(named: "register_uncheck"), forState: .Normal)
        } else {
            personalRegister = true
            enterPriseButton.setImage(UIImage.init(named: "register_uncheck"), forState: .Normal)
            personalButton.setImage(UIImage.init(named: "register_checked"), forState: .Normal)
        }
    }
    
    func gotoProtocol() {
        let proto = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProtocolViewController") as! ProtocolViewController
        
        self.navigationController?.pushViewController(proto, animated: true)
    }
    
    
    func checkValidation() -> Bool {
        
        guard self.cellphone!.isValidCellPhone else {
            showAlertWithMessage("请输入11位手机号码", block: { (_) -> Void in
                
            })
            return false
        }
        
        guard self.cellphone != "" else {
            showAlertWithMessage("手机不能输入为空", block: { (_) -> Void in
                
            })
            return false
        }
        
        guard (self.password as NSString).length >= 6 else {
            showAlertWithMessage("请输入至少6位密码", block: { (_) -> Void in
                
            })
            return false
        }
        guard self.validCode != "" else {
            showAlertWithMessage("请输入验证码", block: { (_) -> Void in
                
            })
            return false
        }
        
        
        guard self.password != "" else {
            showAlertWithMessage("请输入密码", block: { (_) -> Void in
                
            })
            
            return false
        }
        
        guard self.password!.isValidPassword else {
            showAlertWithMessage("密码为6-16位字母数字", block: { (_) -> Void in
                
            })
            
            return false
        }
        
        
        guard userProtocolChecked else {
            showAlertWithMessage("请勾选同意注册协议", block: { (_) -> Void in
                
            })
            
            return false
        }
        
        return true
    }

    func configureFetchValidCode(mode: CMValidateButtonMode) {
        
        if mode == .Timer {
            let string = "\(timerCount) s"
            verifyButton.userInteractionEnabled = false
            verifyButton.setAttributedTitle(NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor(),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        } else {
            
            verifyButton.userInteractionEnabled = true
            verifyButton.setAttributedTitle(NSAttributedString(string: "重新获取验证码", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor(),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        }
        
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
        } else if textfield == verifyTextField {
            validCode = textfield.text
            let text = NSString(string: validCode!)
            if text.length > 6 {
                textfield.text = text.substringToIndex(6)
                validCode = textfield.text
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        register()
        return true
    }
    
    func verify() {
        //获取验证码
        if cellphone.isValidCellPhone {
            self.timer = NSTimer.YQ_scheduledTimerWithTimeInterval(1.0, closure: {
                    self.timerCount -= 1
                    if self.timerCount <= 0 {
                        self.restoreTimer()
                    } else {
                        self.configureFetchValidCode(.Timer)
                        self.verifyButton.userInteractionEnabled = false
                    }
                }, repeats: true)
            
            SVProgressHUD.show()
            NetworkHelper.instance.request(.GET, url: URLConstant.getMobileValidCode.contant, parameters: ["username": cellphone, "phone":cellphone,"busiType": "reg"], completion: { (result: DataResponse?) in
                SVProgressHUD.showSuccessWithStatus("验证码获取成功")
                
            }) { (errMsg, errCode) in
                SVProgressHUD.showErrorWithStatus(errMsg ?? "验证码获取失败")
                self.restoreTimer()
            }
        } else {
            showAlertWithMessage("请输入正确的手机号码", block: nil)
        }
    }
    

    func restoreTimer() {
        self.timerCount = 60
        self.timer?.invalidate()
        self.configureFetchValidCode(.Normal)
        self.verifyButton.userInteractionEnabled = true
    }


    deinit{
        self.timer?.invalidate()
        self.timer = nil
        NSNotificationCenter.defaultCenter().removeObserver(self)
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

enum CMValidateButtonMode {
    case Normal
    case Timer
}






