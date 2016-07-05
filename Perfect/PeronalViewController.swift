//
//  PeronalViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
import Async
class PeronalViewController: BaseViewController, GenderSelectionDelegate, TypeSelectionDelegate, DateSelectionDelegate, UITextFieldDelegate{

    var name: String? = "" {
        willSet {
            if let v = newValue  {
                self.nameTextField.text = v
            }
        }
    }
    
    var gender: String? = "" {
        willSet {
            if let v = newValue where v == "male" {
                genderLabel.text = "男"
            } else if let v = newValue where v == "female"{
                genderLabel.text = "女"
            } else {
                genderLabel.text = ""
            }
        }
    }
    
    var type: String? = "" {
        willSet {
            if let v = newValue where v == "person" {
                typeLabel.text = "个人"
            } else if let v = newValue where v == "company"{
                typeLabel.text = "公司"
            } else {
                typeLabel.text = ""
            }
        }
    }
    
    var typeLabel: UILabel!
    var genderLabel: UILabel!
    var birthLabel: UILabel!
    var birth: String? = "" {
        willSet {
            if let v = newValue {
                birthLabel.text = v
            }
        }
    }
    var scrollView: UIScrollView!
    var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人资料"
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
        scrollView.alwaysBounceVertical = true
        
        let mainView = UIView()
        mainView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(25.pixelToPoint)
        }

        let nameTitleLabel = UILabel()
        nameTitleLabel.text = "姓名"
        nameTitleLabel.textColor = UIColor.init(hexString: "#333333")
        nameTitleLabel.font = UIFont.systemFontOfSize(14)
        mainView.addSubview(nameTitleLabel)
        nameTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(mainView).offset(24.pixelToPoint)
            make.top.equalTo(31.pixelToPoint)
        }
        
        nameTextField = UITextField()
        nameTextField.textColor = UIColor.init(hexString: "#333333")
        nameTextField.text = ""
        nameTextField.font = UIFont.systemFontOfSize(14)
        nameTextField.textAlignment = .Right
        nameTextField.returnKeyType = .Done
        nameTextField.addTarget(self, action: #selector(self.textdidChanged(_:)), forControlEvents: .EditingChanged)
        nameTextField.delegate = self
        mainView.addSubview(nameTextField)
        nameTextField.snp_makeConstraints { (make) in
            make.right.equalTo(mainView).offset(-24.pixelToPoint)
            make.centerY.equalTo(nameTitleLabel)
            make.width.equalTo(300)
        }
        
        let line0 = UIView()
        line0.backgroundColor = UIColor.init(hexString: "#cccccc")
        mainView.addSubview(line0)
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.height.equalTo(0.5)
            make.top.equalTo(nameTitleLabel.snp_bottom).offset(34.pixelToPoint)
        }
        
        let genderTitleLabel = UILabel()
        genderTitleLabel.text = "性别"
        genderTitleLabel.textColor = UIColor.init(hexString: "#333333")
        genderTitleLabel.font = UIFont.systemFontOfSize(14)
        mainView.addSubview(genderTitleLabel)
        genderTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel)
            make.centerY.equalTo(nameTitleLabel).offset(95.pixelToPoint)
        }
        
        genderLabel = UILabel()
        mainView.addSubview(genderLabel)
        genderLabel.text = ""
        genderLabel.textColor = UIColor.init(hexString: "#333333")
        genderLabel.font = UIFont.systemFontOfSize(14)
        genderLabel.snp_makeConstraints { (make) in
            make.right.equalTo(nameTextField)
            make.centerY.equalTo(genderTitleLabel)
        }
        
        let genderbutton  = UIButton.init(type: .Custom)
        genderbutton.backgroundColor = UIColor.clearColor()
        genderbutton.addTarget(self, action: #selector(self.changeGender), forControlEvents: .TouchUpInside)
        mainView.addSubview(genderbutton)
        genderbutton.snp_makeConstraints { (make) in
            make.left.equalTo(genderTitleLabel)
            make.right.equalTo(genderLabel)
            make.height.equalTo(90.pixelToPoint)
            make.centerY.equalTo(genderLabel)
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.init(hexString: "#cccccc")
        
        mainView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(line0)
            make.height.equalTo(0.5).priority(1000)
            make.top.equalTo(genderTitleLabel.snp_bottom).offset(34.pixelToPoint)
        }
        
        let birthTitleLabel = UILabel()
        birthTitleLabel.text = "出生日期"
        birthTitleLabel.textColor = UIColor.init(hexString: "#333333")
        birthTitleLabel.font = UIFont.systemFontOfSize(14)
        mainView.addSubview(birthTitleLabel)
        birthTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel)
            make.centerY.equalTo(genderTitleLabel).offset(95.pixelToPoint)
        }
        
        birthLabel = UILabel()
        mainView.addSubview(birthLabel)
        birthLabel.text = ""
        birthLabel.textColor = UIColor.init(hexString: "#333333")
        birthLabel.font = UIFont.systemFontOfSize(14)
        birthLabel.snp_makeConstraints { (make) in
            make.right.equalTo(nameTextField)
            make.centerY.equalTo(birthTitleLabel)
        }
        
        let birthbutton  = UIButton.init(type: .Custom)
        birthbutton.backgroundColor = UIColor.clearColor()
        birthbutton.addTarget(self, action: #selector(self.changeBirth), forControlEvents: .TouchUpInside)
        mainView.addSubview(birthbutton)
        birthbutton.snp_makeConstraints { (make) in
            make.left.equalTo(birthTitleLabel)
            make.right.equalTo(birthLabel)
            make.height.equalTo(90.pixelToPoint)
            make.centerY.equalTo(birthTitleLabel)
        }
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.init(hexString: "#cccccc")
        mainView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.height.equalTo(line0)
            make.top.equalTo(birthTitleLabel.snp_bottom).offset(34.pixelToPoint)
        }

        let typeTitleLabel = UILabel()
        mainView.addSubview(typeTitleLabel)
        typeTitleLabel.text = "用户类别"
        typeTitleLabel.textColor = UIColor.init(hexString: "#333333")
        typeTitleLabel.font = UIFont.systemFontOfSize(14)
        typeTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel)
            make.centerY.equalTo(birthTitleLabel).offset(95.pixelToPoint)
            make.bottom.equalTo(mainView.snp_bottom).offset(-34.pixelToPoint)
        }

        typeLabel = UILabel()
        mainView.addSubview(typeLabel)
        typeLabel.text = self.type
        typeLabel.textColor = UIColor.init(hexString: "#333333")
        typeLabel.font = UIFont.systemFontOfSize(14)
        typeLabel.snp_makeConstraints { (make) in
            make.right.equalTo(nameTextField)
            make.centerY.equalTo(typeTitleLabel)
        }
        
        let typebutton  = UIButton.init(type: .Custom)
        typebutton.backgroundColor = UIColor.clearColor()
        typebutton.addTarget(self, action: #selector(self.changeType), forControlEvents: .TouchUpInside)
        mainView.addSubview(typebutton)
        typebutton.snp_makeConstraints { (make) in
            make.left.equalTo(typeTitleLabel.snp_right)
            make.right.equalTo(typeLabel)
            make.height.equalTo(95.pixelToPoint)
            make.centerY.equalTo(typeTitleLabel)
        }

        SVProgressHUD.show()
        NetworkHelper.instance.request(.GET, url: URLConstant.getLoginMemberInfo.contant, parameters: nil, completion: { (result: MemberInfoResponse?) in
                SVProgressHUD.dismiss()

                self.name = result?.retObj?.name
                self.gender = result?.retObj?.gender
                self.birth = result?.retObj?.birth
                self.type = result?.retObj?.type
        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg ?? "个人信息获取失败")
        }
    }
    
    func changeGender() {
        let gender = CMProfileGenderViewController.init(nibName: "CMProfileGenderViewController", bundle: nil)
        gender.delegate = self
        gender.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(gender, animated: true, completion: nil)
        
    }
    
    //MARK: 性别
    
    func didSelectedGenderType(type: Gender) {
        if type == Gender.Male {
            SVProgressHUD.show()

            NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["gender": "male"], completion: { (result: DataResponse?) in
                self.gender = "male"
                SVProgressHUD.dismiss()

                }, failed: { (msg, code) in
                    SVProgressHUD.showErrorWithStatus(msg)
            })
        } else if type == Gender.Female{
            SVProgressHUD.show()

            NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["gender": "female"], completion: { (result: DataResponse?) in
                SVProgressHUD.dismiss()

                self.gender = "female"
                }, failed: { (msg, code) in
                    SVProgressHUD.showErrorWithStatus(msg)
            })
        }
    }
    
    func changeType() {
        let typeVC = RegisterTypeViewController.init(nibName: "RegisterTypeViewController", bundle: nil)
        typeVC.modalPresentationStyle = .OverCurrentContext
        typeVC.delegate  = self
        self.presentViewController(typeVC, animated: true, completion: nil)
    }
    
    func didselectedIndex(index: Int) {
        if index == 0 {
            SVProgressHUD.show()
            NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["type": "person"], completion: { (result: DataResponse?) in
                self.type = "person"
                SVProgressHUD.dismiss()

                }, failed: { (msg, code) in
                    SVProgressHUD.showErrorWithStatus(msg)
            })
        } else if index == 1 {
            SVProgressHUD.show()

            NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["type": "company"], completion: { (result: DataResponse?) in
                self.type = "company"
                SVProgressHUD.dismiss()

                }, failed: { (msg, code) in
                    SVProgressHUD.showErrorWithStatus(msg)
            })
        }
    }
    
    
    func changeBirth() {
        let birthVC = BirthdayViewController.init(nibName: "BirthdayViewController", bundle: nil)
        birthVC.delegate  = self
        birthVC.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(birthVC, animated: true, completion: nil)

    }
    
    func didselectedDate(date: String) {
        SVProgressHUD.show()
        NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["birth": date], completion: { (result: DataResponse?) in
            self.birth = date
            SVProgressHUD.dismiss()
            }, failed: { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)
        })
    }
    
    func textdidChanged(textfield: UITextField) {
        let name = textfield.text! as NSString
        if name.length > 20 {
            textfield.text = name.substringToIndex(20)
        }
        
        self.name = textfield.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text == "" {
            SVProgressHUD.showErrorWithStatus("请输入姓名")
            return false
        }
        
        SVProgressHUD.show()
        
        NetworkHelper.instance.request(.GET, url: URLConstant.updateLoginMemberInfo.contant, parameters: ["name": self.name!], completion: { (result: DataResponse?) in
            SVProgressHUD.showSuccessWithStatus("修改成功")
            Async.main(after: 1.0, block: { 
                self.navigationController?.popViewControllerAnimated(true)
            })
            }, failed: { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)
        })
        
        
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func save() {
        
    }
}

