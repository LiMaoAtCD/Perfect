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
    
    var addressString: String! = ""
    var areaID: Int64 = 0
    var cellphone: String! = ""
    var name: String! = ""
    var detailAddress: String! = ""
    
    var id: Int64 = -1
    
    var entity: AddressItemsEntity? {
        willSet {
            if let item = newValue {
                self.name = item.contactName
                self.cellphone = item.contactPhone
                self.addressString = item.areaFullName ?? ""
                self.detailAddress = item.contactAddress ?? ""
                self.id = item.id
                self.areaID = item.areaId
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "收货地址管理"
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.globalBackGroundColor()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        setupUpper()
        
        finishedButton = UIButton()
        scrollView.addSubview(finishedButton)
        finishedButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(95.pixelToPoint)
            make.top.equalTo(upperView.snp_bottom).offset(20.pixelToPoint)
        }
        finishedButton.backgroundColor = UIColor.whiteColor()
        finishedButton.setTitle("完成", forState: .Normal)
        finishedButton.setTitleColor(UIColor.init(hexString: "#ee304e"), forState: .Normal)
        finishedButton.addTarget(self, action: #selector(self.finishEdit), forControlEvents: .TouchUpInside)
    }
    

    func setupUpper() {
        upperView = UIView()
        upperView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(upperView)
        upperView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView).offset(25.pixelToPoint)
            make.height.equalTo(300).priority(500)
        }
        
        let title0 = UILabel()
        title0.text = "收货人"
        title0.textColor = UIColor.init(hexString: "#333333")
        title0.font = UIFont.systemFontOfSize(15.0)
        upperView.addSubview(title0)
        title0.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(24.pixelToPoint)
            make.top.equalTo(upperView).offset(31.pixelToPoint)
            make.width.lessThanOrEqualTo(70)
        }
        
        nameTextfield = UITextField.init()
        upperView.addSubview(nameTextfield)
        if self.name == "" {
            nameTextfield.attributedPlaceholder = NSAttributedString.init(string: "请输入姓名", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#333333", withAlpha: 1.0),NSFontAttributeName: UIFont.systemFontOfSize(15.0)])

        } else {
            nameTextfield.attributedPlaceholder = NSAttributedString.init(string: self.name, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#333333", withAlpha: 1.0),NSFontAttributeName: UIFont.systemFontOfSize(15.0)])

        }
        nameTextfield.textColor = UIColor.init(hexString: "#333333", withAlpha: 1.0)
        nameTextfield.addTarget(self, action: #selector(self.textFieldDidEditChanged(_:)), forControlEvents: .EditingChanged)
        nameTextfield.snp_makeConstraints { (make) in
            make.left.equalTo(title0.snp_right).offset(10)
            make.right.equalTo(upperView)
            make.centerY.equalTo(title0)
        }
        let line0 = UIView()
        line0.backgroundColor = UIColor.init(hexString: "#cccccc")
        upperView.addSubview(line0)
        line0.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(upperView).offset(95.pixelToPoint)
        }
        
        let title1 = UILabel()
            title1.text = "联系电话"
      
        title1.textColor = UIColor.init(hexString: "#333333")
        title1.font = UIFont.systemFontOfSize(15.0)

        upperView.addSubview(title1)
        title1.snp_makeConstraints { (make) in
            make.left.equalTo(upperView).offset(24.pixelToPoint)
            make.top.equalTo(title0).offset(95.pixelToPoint)
        }
        
        phoneTextfield = UITextField.init()
        if self.cellphone == "" {
            phoneTextfield.attributedPlaceholder = NSAttributedString.init(string: "请输入联系电话", attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#333333", withAlpha: 1.0),NSFontAttributeName: UIFont.systemFontOfSize(15.0)])

        } else {
            phoneTextfield.attributedPlaceholder = NSAttributedString.init(string: self.cellphone, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#333333", withAlpha: 1.0),NSFontAttributeName: UIFont.systemFontOfSize(15.0)])
        }
        phoneTextfield.textColor = UIColor.init(hexString: "#333333", withAlpha: 1.0)
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
        line1.backgroundColor = UIColor.init(hexString: "#cccccc")

        upperView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(line0).offset(95.pixelToPoint)
        }
        
        
        let title2 = UILabel()
        title2.text = "所在地区"
        title2.textColor = UIColor.init(hexString: "#333333")
        title2.font = UIFont.systemFontOfSize(15.0)
        upperView.addSubview(title2)
        title2.snp_makeConstraints { (make) in
            make.left.equalTo(title0)
            make.top.equalTo(title1).offset(95.pixelToPoint)
        }
        
        addressLabel = UILabel.init()
        if self.addressString == "" {
            addressLabel.text = "请选择所在地区"
        } else {
            addressLabel.text = self.addressString
        }
        addressLabel.textColor = UIColor.init(hexString: "#333333")
        addressLabel.font = UIFont.systemFontOfSize(15.0)
        upperView.addSubview(addressLabel)
        addressLabel.userInteractionEnabled = true
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(phoneTextfield)
            make.right.equalTo(upperView)
            make.height.equalTo(35)
            make.centerY.equalTo(title2)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.chooseAddress))
        addressLabel.addGestureRecognizer(tap)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.init(hexString: "#cccccc")

        upperView.addSubview(line2)
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(upperView)
            make.height.equalTo(0.3)
            make.top.equalTo(line1).offset(95.pixelToPoint)
        }
        
        let detailAddress = UITextView.init()
        detailAddress.font = UIFont.systemFontOfSize(15.0)
        detailAddress.textColor = UIColor.init(hexString: "#333333")
        detailAddress.delegate = self
        upperView.addSubview(detailAddress)
        detailAddress.snp_makeConstraints { (make) in
            make.left.equalTo(title2)
            make.right.equalTo(upperView).offset(-14)
            make.top.equalTo(line2).offset(43.pixelToPoint)
            make.height.equalTo(176.pixelToPoint)
            make.bottom.equalTo(upperView.snp_bottom)
        }
        
        if self.detailAddress == "" {
            detailAddress.text = "请输入详细地址(例如 xxx 街道 xxx 号)"
        } else {
            detailAddress.text = self.detailAddress
        }
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
        if textView.text == "请输入详细地址(例如 xxx 街道 xxx 号)" {
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
