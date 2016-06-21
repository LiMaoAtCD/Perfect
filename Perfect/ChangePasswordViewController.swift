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
        scrollView.backgroundColor = UIColor(hexString: "#cccccc")
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        setupViews()
        
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
        
        oldPasswordLabel = UILabel()
        oldPasswordLabel.text = "旧密码"
        oldPasswordLabel.textColor = UIColor.blackColor()
        view0.addSubview(oldPasswordLabel)
        oldPasswordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(view0.snp_centerY)
            make.width.lessThanOrEqualTo(80)
        }
        oldPasswordTextfield = UITextField()
        oldPasswordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        oldPasswordTextfield.placeholder = "请输入您的密码"
        oldPasswordTextfield.keyboardType = .NumberPad
        view0.addSubview(oldPasswordTextfield)
        
        oldPasswordTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordLabel.snp_right).offset(14)
            make.centerY.equalTo(oldPasswordLabel)
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
        
        passwordLabel = UILabel()
        passwordLabel.text = "新密码"
        passwordLabel.textColor = UIColor.blackColor()
        
        view1.addSubview(passwordLabel)
        
        passwordLabel.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordLabel)
            make.centerY.equalTo(view1)
        }
        
        passwordTextfield = UITextField()
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        passwordTextfield.placeholder = "请输入6-16位密码"
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
            make.top.equalTo(view1.snp_bottom).offset(20)
        }
        
        confirmLabel = UILabel()
        confirmLabel.text = "确认密码"
        confirmLabel.textColor = UIColor.blackColor()
        
        view2.addSubview(confirmLabel)
        
        confirmLabel.snp_makeConstraints { (make) in
            make.left.equalTo(passwordLabel)
            make.centerY.equalTo(view2)
        }
        
        comfirmTextfield = UITextField()
        comfirmTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        comfirmTextfield.placeholder = "请输入6-16位密码"
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
        sureButton.backgroundColor = UIColor.flatMintColor()
        sureButton.layer.cornerRadius = 3.0
        sureButton.layer.masksToBounds = true
        scrollView.addSubview(sureButton)
        
        sureButton.snp_makeConstraints { (make) in
            make.top.equalTo(view2.snp_bottom).offset(30)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(45)
            make.left.equalTo(14)
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
//        NetworkHelper.instance.request(.GET, url: URLConstant.resetPasswordByMobile.contant, parameters: ["username": cellphone, "password": password,"validCode": validCode], completion: { [weak self](result: DataResponse?) in
//                SVProgressHUD.showSuccessWithStatus("密码修改成功")
//                Async.main(after: 1.0, block: {
//                    self?.navigationController?.popViewControllerAnimated(true)
//                })
//            }) { (errMsg, errCode) in
//                if errCode == 1 {
//                    SVProgressHUD.showErrorWithStatus("用户名或手机号码不存在")
//                } else if errCode == 2 {
//                    SVProgressHUD.showErrorWithStatus("验证码不正确")
//                } else if errCode == 3 {
//                    SVProgressHUD.showErrorWithStatus("输入项格式不符合要求")
//                } else {
//                    SVProgressHUD.showErrorWithStatus("密码修改失败")
//                }
//        }
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
