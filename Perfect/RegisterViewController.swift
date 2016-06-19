//
//  RegisterViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import ChameleonFramework

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
    
    
    
    var timer: NSTimer?
    var timerCount: Int = 60
    
    var cellphone: String! = ""
    var validCode: String! = ""
    var password: String! = ""
    
    
    
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "注册"
        
        scrollView = UIScrollView.init()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        setupViews()
        
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
        passwordLabel.text = "密码"
        passwordLabel.textColor = UIColor.blackColor()
        
        scrollView.addSubview(passwordLabel)
        
        cellphoneTextfield = UITextField()
        cellphoneTextfield.delegate = self
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
        passwordTextfield.placeholder = "请设定密码"
        passwordTextfield.secureTextEntry = true
        scrollView.addSubview(passwordTextfield)
        
        verifyButton = UIButton.init(type: .Custom)
        verifyButton.setAttributedTitle(NSAttributedString(string: "获取验证码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#666666"),NSFontAttributeName: UIFont.systemFontOfSize(12)]), forState: .Normal)

        verifyButton.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        scrollView.addSubview(verifyButton)
        
        protocolButton = UIButton.init(type: .Custom)
        protocolButton.setTitle("《APP使用协议》", forState: .Normal)
        protocolButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        
        protocolButton.addTarget(self, action: #selector(self.protocolClick), forControlEvents: .TouchUpInside)
        scrollView.addSubview(protocolButton)
//
        registerButton = UIButton.init(type: .Custom)
        registerButton.addTarget(self, action: #selector(self.register), forControlEvents: .TouchUpInside)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.backgroundColor = UIColor.brownColor()
        registerButton.layer.cornerRadius = 3.0
        registerButton.layer.masksToBounds = true
        scrollView.addSubview(registerButton)
        
        
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
            make.right.equalTo(-50)
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
    
        registerButton.snp_makeConstraints { (make) in
            make.top.equalTo(line3.snp_bottom).offset(60)
            make.centerX.equalTo(scrollView)
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
        if cellphone.isValidCellPhone {}
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
            showAlertWithMessage("密码格式支持数字、大小写字母，不支持空格", block: { (_) -> Void in
                
            })
            
            return false
        }
        
        
//        guard userProtocolChecked else {
//            showAlertWithMessage("请勾选同意《用户使用协议》", block: { (_) -> Void in
//                
//            })
//            
//            return false
//        }
        
        
        return true
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

    
    func protocolClick() -> Void {
        let proto = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProtocolViewController") as! ProtocolViewController
        
        self.navigationController?.pushViewController(proto, animated: true)

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
    
    func verify() {
        
        guard self.cellphone.isValidCellPhone else {
            self.showAlertWithMessage("请输入正确的手机号", block: nil)
            return
        }
        
        timer = NSTimer.YQ_scheduledTimerWithTimeInterval(0.1, closure: {
            self.timerCount -= 1
            if self.timerCount <= 0 {
                self.timerCount = 60
                self.timer?.invalidate()
                self.configureFetchValidCode(.Normal)
                self.verifyButton.userInteractionEnabled = true
            } else {
                self.configureFetchValidCode(.Timer)
                self.verifyButton.userInteractionEnabled = false
            }
            
            }, repeats: true)
    }


    deinit{
        self.timer?.invalidate()
        self.timer = nil
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


public typealias TimerExcuteClosure = @convention(block)()->()
extension NSTimer{
    public class func YQ_scheduledTimerWithTimeInterval(ti:NSTimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> NSTimer{
        return self.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, AnyObject.self), repeats: true)
    }
    
    class func excuteTimerClosure(timer: NSTimer)
    {
        let closure = unsafeBitCast(timer.userInfo, TimerExcuteClosure.self)
        closure()
    }
}


extension UIViewController {
    
    func showAlertWithMessage(message: String?, block: (Void -> Void)?) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (_) -> Void in
            if let _ = block {
                block!()
            }
        }
        
        alertController.addAction(action)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

