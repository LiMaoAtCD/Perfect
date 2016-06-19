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
    var verifyButton: UIButton!
    var cellphoneTextfield: UITextField!
    var verifyTextField: UITextField!
    var passwordTextfield: UITextField!
    var sureButton: UIButton!
    
    var timer: NSTimer?
    var timerCount: Int = 60
    
    var cellphone: String! = ""
    var validCode: String! = ""
    var password: String! = ""
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        scrollView = UIScrollView.init()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        setupViews()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        
        cellphoneLabel = UILabel()
        cellphoneLabel.text = "手机号码"
        cellphoneLabel.textColor = UIColor.blackColor()
        scrollView.addSubview(cellphoneLabel)
        
        verifyCodeLabel = UILabel()
        verifyCodeLabel.text = "验证码"
        verifyCodeLabel.textColor = UIColor.blackColor()
        scrollView.addSubview(verifyCodeLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = "新密码"
        passwordLabel.textColor = UIColor.blackColor()
        
        scrollView.addSubview(passwordLabel)
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        cellphoneTextfield.placeholder = "请输入号码"
        cellphoneTextfield.keyboardType = .NumberPad
        scrollView.addSubview(cellphoneTextfield)
        
        verifyTextField = UITextField()
        verifyTextField.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        verifyTextField.placeholder = "请输入验证码"
        verifyTextField.keyboardType = .NumberPad
        
        scrollView.addSubview(verifyTextField)
        
        passwordTextfield = UITextField()
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.placeholder = "请输入新密码"
        passwordTextfield.secureTextEntry = true
        scrollView.addSubview(passwordTextfield)
        
        verifyButton = UIButton.init(type: .Custom)
        verifyButton.setAttributedTitle(NSAttributedString(string: "获取验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#666666"),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)
        
        verifyButton.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        scrollView.addSubview(verifyButton)
        
        //
        sureButton = UIButton.init(type: .Custom)
        sureButton.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        sureButton.setTitle("确认修改", forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureButton.backgroundColor = UIColor.brownColor()
        sureButton.layer.cornerRadius = 3.0
        sureButton.layer.masksToBounds = true
        scrollView.addSubview(sureButton)
        
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(line0)
        
        line0.hidden = true
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(line1)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(line2)
        
        let line3 = UIView()
        line3.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(line3)
        
        
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(10)
            make.height.equalTo(1)
        }
        
        
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(line0)
            make.top.equalTo(line0.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(line0)
            make.top.equalTo(line1.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        line3.snp_makeConstraints { (make) in
            make.left.right.equalTo(line0)
            make.top.equalTo(line2.snp_bottom).offset(60)
            make.height.equalTo(1)
        }
        
        cellphoneLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(line0.snp_bottom).offset(30)
            make.width.lessThanOrEqualTo(80).priority(1000)
        }
        
        cellphoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(cellphoneLabel.snp_right).offset(8)
            make.centerY.equalTo(cellphoneLabel)
            make.right.equalTo(verifyButton.snp_left).offset(-8)
            make.height.equalTo(35)
        }
        
        verifyButton.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-10)
            make.centerY.equalTo(cellphoneTextfield.snp_centerY)
            make.width.lessThanOrEqualTo(80)
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
        
        sureButton.snp_makeConstraints { (make) in
            make.top.equalTo(line3.snp_bottom).offset(60)
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
        NetworkHelper.instance.request(.GET, url: URLConstant.resetPasswordByMobile.contant, parameters: ["username": cellphone, "password": password,"validCode": validCode], completion: { [weak self](result: DataResponse?) in
            SVProgressHUD.showSuccessWithStatus("密码修改成功")
            Async.main(after: 1.0, block: {
                self?.navigationController?.popViewControllerAnimated(true)
            })
        }) { (errMsg, errCode) in
            SVProgressHUD.showErrorWithStatus(errMsg)
        }
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
                self.restoreTimer()

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
