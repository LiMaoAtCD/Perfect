//
//  AddressEditViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/20.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD
import Async
class AddressEditViewController: BaseViewController, UITextViewDelegate {

    var scrollView: UIScrollView!
    var upperView: UIView!
    var finishedButton: UIButton!
    var nameTextfield: UITextField!
    var phoneTextfield: UITextField!
    
    var addressLabel: UILabel!
    
    var addressString: String = ""
    var areaID: Int64 = 0
    var cellphone: String! = ""
    var name: String! = ""
    var detailAddress: String! = ""
    
    var id: Int64 = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "收货地址管理"
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(hexString: "#cccccc")
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        setupUpper()
        
        finishedButton = UIButton()
        scrollView.addSubview(finishedButton)
        finishedButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(50)
            make.top.equalTo(upperView.snp_bottom).offset(15)
        }
        finishedButton.backgroundColor = UIColor.whiteColor()
        finishedButton.setTitle("完成", forState: .Normal)
        finishedButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        finishedButton.addTarget(self, action: #selector(self.finishEdit), forControlEvents: .TouchUpInside)
    }
    

    func setupUpper() {
        upperView = UIView()
        upperView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(upperView)
        upperView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(20)
            make.height.equalTo(300).priority(500)
        }
        
        let title0 = UILabel()
        title0.text = "收货人"
        upperView.addSubview(title0)
        title0.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(upperView).offset(20)
            make.width.lessThanOrEqualTo(70)
        }
        
        nameTextfield = UITextField.init()
        upperView.addSubview(nameTextfield)
        nameTextfield.placeholder = "请输入您的姓名"
        nameTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        nameTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(title0.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title0)
        }
        let line0 = UIView()
        line0.backgroundColor = UIColor(hexString: "#cccccc")
        upperView.addSubview(line0)
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50)
        }
        
        let title1 = UILabel()
        title1.text = "联系电话"
        upperView.addSubview(title1)
        title1.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(line0).offset(20)
        }
        
        phoneTextfield = UITextField.init()
        phoneTextfield.placeholder = "请输入您的电话"
        phoneTextfield.keyboardType = .NumberPad
        phoneTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)

        upperView.addSubview(phoneTextfield)
        phoneTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(nameTextfield)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title1)
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor(hexString: "#cccccc")

        upperView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50 * 2)
        }
        
        
        let title2 = UILabel()
        title2.text = "所在地区"
        upperView.addSubview(title2)
        title2.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(10)
            make.top.equalTo(line1).offset(20)
        }
        
        addressLabel = UILabel.init()
        upperView.addSubview(addressLabel)
        addressLabel.userInteractionEnabled = true
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(title2.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title2)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.chooseAddress))
        addressLabel.addGestureRecognizer(tap)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor(hexString: "#cccccc")

        upperView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(50 * 3)
        }
        
        let detailAddress = UITextView.init()
        detailAddress.delegate = self
        upperView.addSubview(detailAddress)
        detailAddress.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(8)
            make.right.equalTo(upperView).offset(-8)
            make.top.equalTo(line2).offset(10)
            make.height.equalTo(100)
            make.bottom.equalTo(upperView.snp_bottom)
        }
        detailAddress.text = "详细地址"
    }
    
    
    //选择地址
    func chooseAddress() {
        let vc = AddressChooseViewController.someController(AddressChooseViewController.self, ofStoryBoard: UIStoryboard.main)
        
        vc.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(vc, animated: false, completion: nil)
        
        vc.handler = {
            [weak self](areaID, address) in
            
            self?.areaID = areaID
            self?.addressString = address ?? ""
            self?.addressLabel.text = self?.addressString
            
            print((self?.addressString)! + String(self?.areaID))
        }
    }
    
    //MARK: 输入框处理
    func textFieldDidEditChanged(textfield: UITextField) {
        //
        if textfield == nameTextfield {
            name = textfield.text
            let text = NSString(string: name)
            if text.length > 11 {
                textfield.text = text.substringToIndex(11)
                cellphone = textfield.text
            }
        } else if textfield == phoneTextfield {
            cellphone = textfield.text
            let text = NSString(string: cellphone!)
            if text.length > 11 {
                textfield.text = text.substringToIndex(11)
                cellphone = textfield.text
            }
        } else {
            
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.text == "详细地址" {
            textView.text = ""
        }
        
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        detailAddress = textView.text
    }
    
    func finishEdit() {
        
        if self.name == "" {
            showAlertWithMessage("姓名不能为空", block: nil)
            return
        } else if !self.cellphone.isValidCellPhone {
            showAlertWithMessage("手机号码不正确", block: nil)
            return
        } else if detailAddress == "" {
            showAlertWithMessage("详细地址不能为空", block: nil)
            return
        } else if self.areaID == 0 {
            showAlertWithMessage("地址不能为空", block: nil)
            return
        }
        
        var params = [String:AnyObject]()
        if id != -1 {
            params["id"] = NSNumber.init(longLong: id)
        }
        params["name"] = name
        params["phone"] = cellphone
        params["address"] = detailAddress
        params["areaId"] = NSNumber.init(longLong: self.areaID)
        
        
        SVProgressHUD.showWithStatus("正在处理")
        NetworkHelper.instance.request(.GET, url: URLConstant.saveOrUpdateLoginMemberDeliveryAddress.contant, parameters: params, completion: { (result: DataResponse?) in
                SVProgressHUD.showSuccessWithStatus("操作成功")
                Async.main(after: 1.0, block: { 
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }) { (errormsg, errcode) in
                SVProgressHUD.showErrorWithStatus(errormsg ?? "地址修改失败")
        }
    }


//    id	id	int	false	对应收件地址列表中的id,为空时新建,不为空时更新
//    areaId	区域ID	int	true	要求选择到区县级
//    name	收件人姓名	string	true
//    phone	收件人电话	string	true
//    address	收件人电话	string	true
//    isDefault	是否默认	bool	false
    
    
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
