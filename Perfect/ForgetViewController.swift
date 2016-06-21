//
//  ForgetViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
import Async

class ForgetViewController: BaseViewController, UITextFieldDelegate {
    
    var cellphoneLabel: UILabel!
    var verifyCodeLabel: UILabel!
    var passwordLabel: UILabel!
    var confirmLabel: UILabel!
    
    var verifyButton: UIButton!
    var cellphoneTextfield: UITextField!
    var verifyTextField: UITextField!
    var passwordTextfield: UITextField!
    var confirmTextfield: UITextField!

    var sureButton: UIButton!
    
    var timer: NSTimer?
    var timerCount: Int = 60
    
    var cellphone: String! = ""
    var validCode: String! = ""
    var password: String! = ""
    var confirm: String! = ""
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        scrollView = UIScrollView.init()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor(hexString: "#cccccc")
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        setupViews()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        self.scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        self.confirmTextfield.resignFirstResponder()
        self.cellphoneTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
        self.verifyTextField.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        
        let view0 = UIView()
        view0.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view0)
        
        view0.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(20)
            make.height.equalTo(50)
        }
        
        cellphoneLabel = UILabel()
        cellphoneLabel.text = "手机号"
        cellphoneLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, forAxis: UILayoutConstraintAxis.Horizontal)
        cellphoneLabel.textColor = UIColor.blackColor()
        view0.addSubview(cellphoneLabel)
        cellphoneLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(view0.snp_centerY)
            make.width.lessThanOrEqualTo(80)
        }
        
        
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        cellphoneTextfield.placeholder = "请输入号码"
        cellphoneTextfield.keyboardType = .NumberPad
        view0.addSubview(cellphoneTextfield)
        
        cellphoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(cellphoneLabel.snp_right).offset(14)
            make.centerY.equalTo(cellphoneLabel)
            make.right.equalTo(view0).offset(-14)
            make.height.equalTo(35)
        }

        let view1 = UIView()
        view1.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view1)
        
        view1.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(view0)
            make.top.equalTo(view0.snp_bottom).offset(20)
        }
        
        verifyCodeLabel = UILabel()
        verifyCodeLabel.text = "验证码"
        verifyCodeLabel.textColor = UIColor.blackColor()
        view1.addSubview(verifyCodeLabel)
        
        verifyCodeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(cellphoneLabel)
            make.centerY.equalTo(view1)
        }
        
        verifyTextField = UITextField()
        verifyTextField.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        verifyTextField.placeholder = "短信验证码"
        verifyTextField.keyboardType = .NumberPad
        
        view1.addSubview(verifyTextField)
        
        
        verifyTextField.snp_makeConstraints { (make) in
            make.left.height.equalTo(cellphoneTextfield)
            make.centerY.equalTo(verifyCodeLabel)
            make.width.lessThanOrEqualTo(100)
        }
        
        verifyButton = UIButton.init(type: .Custom)
        verifyButton.setAttributedTitle(NSAttributedString(string: "发送验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#666666"),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        
        verifyButton.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        view1.addSubview(verifyButton)
        
        verifyButton.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-10)
            make.centerY.equalTo(verifyTextField.snp_centerY)
            make.width.lessThanOrEqualTo(100)
        }
        
        let marginView = UIView()
        marginView.backgroundColor = UIColor.lightGrayColor()
        view1.addSubview(marginView)
        
        marginView.snp_makeConstraints { (make) in
            make.centerY.equalTo(view1)
            make.height.equalTo(30)
            make.width.equalTo(1)
            make.right.equalTo(view).offset(-100)
        }
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view2)
        view2.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(view1)
            make.top.equalTo(view1.snp_bottom).offset(20)
        }
        
        passwordLabel = UILabel()
        passwordLabel.text = "新密码"
        passwordLabel.textColor = UIColor.blackColor()
        
        view2.addSubview(passwordLabel)
        
        passwordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(verifyCodeLabel)
            make.centerY.equalTo(view2)
        }
        
        passwordTextfield = UITextField()
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.placeholder = "请输入6-16位密码"
        passwordTextfield.secureTextEntry = true
        view2.addSubview(passwordTextfield)
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.right.equalTo(cellphoneTextfield)
            make.centerY.equalTo(view2)
            make.height.equalTo(cellphoneTextfield)
        }
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view3)
        view3.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(view0)
            make.top.equalTo(view2.snp_bottom).offset(20)
        }
        
        confirmLabel = UILabel()
        confirmLabel.text = "确认密码"
        confirmLabel.textColor = UIColor.blackColor()
        
        view3.addSubview(confirmLabel)
        
        confirmLabel.snp_makeConstraints { (make) in
            make.left.equalTo(passwordLabel)
            make.centerY.equalTo(view3)
        }
        
        confirmTextfield = UITextField()
        confirmTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        confirmTextfield.placeholder = "请输入6-16位密码"
        confirmTextfield.secureTextEntry = true
        view3.addSubview(confirmTextfield)
        
        confirmTextfield.snp_makeConstraints { (make) in
            make.left.right.equalTo(cellphoneTextfield)
            make.centerY.equalTo(view3)
            make.height.equalTo(cellphoneTextfield)
        }

        
        //
        sureButton = UIButton.init(type: .Custom)
        sureButton.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        sureButton.setTitle("确定", forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureButton.backgroundColor = UIColor.flatMintColor()
        sureButton.layer.cornerRadius = 3.0
        sureButton.layer.masksToBounds = true
        scrollView.addSubview(sureButton)

        sureButton.snp_makeConstraints { (make) in
            make.top.equalTo(view3.snp_bottom).offset(30)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(45)
            make.left.equalTo(14)
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
        }else if textfield == confirmTextfield {
            confirm = textfield.text
            let text = NSString(string: confirm!)
            if text.length > 16 {
                textfield.text = text.substringToIndex(16)
                confirm = textfield.text
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
    
    deinit{
        self.timer?.invalidate()
        self.timer = nil
    }

    
    //MARK: 修改密码
    func sure() {
        if checkValid() {
            NetworkHelper.instance.request(.GET, url: URLConstant.resetPasswordByMobile.contant, parameters: ["username": cellphone, "password": password,"validCode": validCode], completion: { [weak self](result: DataResponse?) in
                    SVProgressHUD.showSuccessWithStatus("修改成功")
                    Async.main(after: 1.0, block: {
                        self?.navigationController?.popViewControllerAnimated(true)
                    })
            }) { (errMsg, errCode) in
                SVProgressHUD.showErrorWithStatus(errMsg)
            }
        }
  }
    
    func checkValid() -> Bool {
        
        if !cellphone.isValidCellPhone {
            showAlertWithMessage("手机号不对", block: nil)
            return false
        }
        
        if !password.isValidPassword {
            showAlertWithMessage("密码为6-16位", block: nil)
            return false
        }
        
        if validCode.isEmpty {
            showAlertWithMessage("验证码不能为空", block: nil)
            return false
        }
        
        if password.isEmpty {
            showAlertWithMessage("密码不能为空", block: nil)
            return false
        }
        if confirm.isEmpty {
            showAlertWithMessage("确认密码不能为空", block: nil)
            return false
        }
        
        if password != confirm {
            showAlertWithMessage("二次密码输入不一致", block: nil)
            return false
        }
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
            NetworkHelper.instance.request(.GET, url: URLConstant.getMobileValidCode.contant, parameters: ["username": cellphone, "phone":cellphone], completion: { (result: DataResponse?) in
                SVProgressHUD.showSuccessWithStatus("验证码获取成功")

            }) { (errMsg, errCode) in
                SVProgressHUD.showErrorWithStatus(errMsg ?? "验证码获取失败")
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

    
    func configureFetchValidCode(mode: CMValidateButtonMode) {
        
        if mode == .Timer {
            let string = "\(timerCount) s"
            verifyButton.userInteractionEnabled = false
            verifyButton.setAttributedTitle(NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#666666"),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        } else {
            
            verifyButton.userInteractionEnabled = true
            verifyButton.setAttributedTitle(NSAttributedString(string: "重新获取验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#666666"),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        }
        
    }


}
