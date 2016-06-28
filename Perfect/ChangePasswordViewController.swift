//
//  ChangePasswordViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/18.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
import Async
class ChangePasswordViewController: BaseViewController {
    
    var oldPasswordLabel: UILabel!
    var oldPasswordTextfield: UITextField!
    var passwordLabel: UILabel!
    var passwordTextfield: UITextField!
    var sureButton: UIButton!
    var confirmLabel: UILabel!
    var comfirmTextfield: UITextField!

    var oldPassword: String! = ""
    var password: String! = ""
    var confirmPassword: String! = ""

    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "修改密码"
        scrollView = UIScrollView.init()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor.init(hexString: "#cccccc")
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
        setupViews()
        
    }
    func setupViews() {
        
        let view0 = UIView()
        view0.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view0)
        
        view0.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(32.pixelToPoint)
            make.height.equalTo(50)
        }
        
        oldPasswordLabel = UILabel()
        oldPasswordLabel.text = "旧密码"
        oldPasswordLabel.font = UIFont.systemFontOfSize(14)

        oldPasswordLabel.textColor = UIColor.init(hexString: "#333333")
        view0.addSubview(oldPasswordLabel)
        oldPasswordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(view0.snp_centerY)
            make.width.lessThanOrEqualTo(60)
        }
        oldPasswordTextfield = UITextField()
        oldPasswordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        oldPasswordTextfield.placeholder = "请输入您的密码"
        oldPasswordTextfield.keyboardType = .NumberPad
        oldPasswordTextfield.attributedPlaceholder = NSAttributedString.init(string: "请输入您的密码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#d9d9d9", withAlpha: 1.0)])
        
        view0.addSubview(oldPasswordTextfield)
        
        oldPasswordTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordLabel.snp_right).offset(14)
            make.centerY.equalTo(oldPasswordLabel)
            make.right.equalTo(view0).offset(-14)
        }
        
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view1)
        
        view1.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(view0)
            make.top.equalTo(view0.snp_bottom).offset(24.pixelToPoint)
        }
        
        passwordLabel = UILabel()
        passwordLabel.text = "新密码"
        passwordLabel.font = UIFont.systemFontOfSize(14)

        passwordLabel.textColor = UIColor.init(hexString: "#333333")
        
        view1.addSubview(passwordLabel)
        
        passwordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordLabel)
            make.centerY.equalTo(view1)
        }
        
        passwordTextfield = UITextField()
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.attributedPlaceholder = NSAttributedString.init(string: "请输入6-16位密码", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#d9d9d9", withAlpha: 1.0)])
        passwordTextfield.secureTextEntry = true
        view1.addSubview(passwordTextfield)
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.left.right.equalTo(oldPasswordTextfield)
            make.centerY.equalTo(view1)
            make.height.equalTo(oldPasswordTextfield)
        }
 
        let view2 = UIView()
        view2.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view2)
        view2.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(view1)
            make.top.equalTo(view1.snp_bottom).offset(24.pixelToPoint)
        }
        
        confirmLabel = UILabel()
        confirmLabel.text = "确认密码"
        confirmLabel.font = UIFont.systemFontOfSize(14)

        confirmLabel.textColor = UIColor.init(hexString: "#333333")
        view2.addSubview(confirmLabel)
        
        confirmLabel.snp_makeConstraints { (make) in
            make.left.equalTo(passwordLabel)
            make.centerY.equalTo(view2)
        }
        
        comfirmTextfield = UITextField()
        comfirmTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        comfirmTextfield.attributedPlaceholder = NSAttributedString.init(string: "", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#d9d9d9", withAlpha: 1.0)])

        comfirmTextfield.secureTextEntry = true
        view2.addSubview(comfirmTextfield)
        
        comfirmTextfield.snp_makeConstraints { (make) in
            make.left.right.equalTo(oldPasswordTextfield)
            make.centerY.equalTo(view2)
            make.height.equalTo(oldPasswordTextfield)
        }
        
        
        //
        sureButton = UIButton.init(type: .Custom)
        sureButton.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        sureButton.setTitle("确定", forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureButton.setBackgroundImage(UIImage.init(named: "address_add_0"), forState: .Normal)
        sureButton.setBackgroundImage(UIImage.init(named: "address_add_1"), forState: .Highlighted)

        sureButton.layer.cornerRadius = 3.0
        sureButton.layer.masksToBounds = true
        scrollView.addSubview(sureButton)
        
        sureButton.snp_makeConstraints { (make) in
            make.top.equalTo(view2.snp_bottom).offset(37.pixelToPoint)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(45)
            make.left.equalTo(24.pixelToPoint)
        }
   }
    
    //MARK: 输入框处理
    func textFieldDidEditChanged(textfield: UITextField) {
        //
        if textfield == oldPasswordTextfield {
            oldPassword = textfield.text
            
            let text = NSString(string: oldPassword!)
            if text.length > 16 {
                textfield.text = text.substringToIndex(16)
                oldPassword = textfield.text
            }
        } else if textfield == passwordTextfield {
            password = textfield.text
            let text = NSString(string: password!)
            if text.length > 6 {
                textfield.text = text.substringToIndex(6)
                password = textfield.text
            }
        } else {
            confirmPassword = textfield.text
            let p = confirmPassword as NSString
            if p.length > 16 {
                textfield.text = p.substringToIndex(16)
                confirmPassword = textfield.text
            }
        }
    }
    
    
    //MARK: 修改密码
    func sure() {
        if checkValid() {
            SVProgressHUD.showWithStatus("正在修改")
            NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberPassword.contant, parameters: ["oldPassword":oldPassword,"password":password], completion: { (result: DataResponse?) in
                    SVProgressHUD.showSuccessWithStatus("密码修改成功")
                    Async.main(after: 1.0, block: { 
                        self.navigationController?.popViewControllerAnimated(true)
                    })
            }) { (msg: String?, code: Int) in
                if code == -2 {
                    let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginNavigationController") as! LoginNavigationController
                    self.presentViewController(login, animated: true, completion: nil)
                } else {
                    SVProgressHUD.showErrorWithStatus(msg ?? "修改失败")
                }
            }
        }
    }

    func checkValid() -> Bool {

        
        guard (self.password as NSString).length >= 6 else {
            showAlertWithMessage("请输入至少6位密码", block: { (_) -> Void in
                
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
        
        guard password == confirmPassword else {
            showAlertWithMessage("二次密码输入不一致", block: { (_) -> Void in
                
            })
            
            return false
        }

        
        return true

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
