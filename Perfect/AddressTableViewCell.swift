//
//  AddressTableViewCell.swift
//  Perfect
//
//  Created by AlienLi on 16/5/30.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var MainView: UIView!
    var name: UILabel!
    var address: UILabel!
    var cellphone: UILabel!
    var marginView: UIView!
    var defaultAddress: CheckView!
    var editView: AddressEditView!
    var deleteView: AddressEditView!
    
    
    var entity: AddressItemsEntity? {
        willSet {
            if let _ = newValue {
                self.address.text = newValue!.areaFullName! + newValue!.contactAddress!
                self.cellphone.text = newValue!.contactPhone
                self.name.text = newValue!.contactName
                self.defaultAddress.choosen = newValue!.isDefault
                self.defaultAddress.id = newValue!.id
                self.editView.id = newValue!.id
                self.editView.isDefault = newValue!.isDefault
                self.deleteView.id = newValue!.id
                self.deleteView.isDefault = newValue!.isDefault
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        MainView = UIView()
        MainView.backgroundColor = UIColor.whiteColor()
        self.addSubview(MainView)
        MainView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self)
        }
        
        
        name = UILabel()
        MainView.addSubview(name)
        name.font = UIFont.systemFontOfSize(15)
        name.textColor = UIColor.init(hexString: "#333333")
        name.snp_makeConstraints { (make) in
            make.left.equalTo(24.pixelToPoint)
            make.top.equalTo(27.pixelToPoint)
            make.width.greaterThanOrEqualTo(50)
        }
        
        cellphone = UILabel()
        MainView.addSubview(cellphone)
        cellphone.snp_makeConstraints { (make) in
            make.right.equalTo(MainView.snp_right).offset(-44.pixelToPoint)
            make.top.equalTo(MainView).offset(36.pixelToPoint)
        }
        
        cellphone.textAlignment = .Right
        cellphone.font = UIFont.systemFontOfSize(13)
        cellphone.textColor = UIColor.init(hexString: "#333333")
        
        address = UILabel()
        MainView.addSubview(address)
        address.font = UIFont.systemFontOfSize(13)
        address.textColor = UIColor.init(hexString: "#333333")
        address.numberOfLines = 0
        address.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp_bottom).offset(60.pixelToPoint)
            make.right.equalTo(cellphone)
        }

        marginView = UIView()
        marginView.backgroundColor = UIColor.init(hexString: "#ebebeb")
        MainView.addSubview(marginView)
        marginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(0.3)
            make.top.equalTo(address.snp_bottom).offset(20)
            make.bottom.equalTo(-89.pixelToPoint)
        }
        
        defaultAddress = CheckView.init(frame: CGRectZero)
        MainView.addSubview(defaultAddress)
        

        defaultAddress.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.width.greaterThanOrEqualTo(100)
            make.centerY.equalTo(marginView.snp_bottom).offset(89.pixelToPoint / 2)
            make.height.equalTo(35)
            make.bottom.equalTo(MainView.snp_bottom).offset(-8)
        }
        
        
        deleteView = AddressEditView.init(frame: CGRectZero)
        MainView.addSubview(deleteView)
        deleteView.snp_makeConstraints { (make) in
            make.right.equalTo(cellphone)
            make.centerY.equalTo(defaultAddress)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(35)
        }
        deleteView.imageView.image = UIImage.init(named: "address_delete")
        deleteView.title.text = "删除"
        
        editView = AddressEditView.init(frame: CGRectMake(0, 0, 200, 100))
        
        MainView.addSubview(editView)
        editView.snp_makeConstraints { (make) in
            make.right.equalTo(deleteView.snp_left).offset(-14)
            make.centerY.equalTo(defaultAddress)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(35)
        }
        editView.imageView.image = UIImage.init(named: "address_edit")
        editView.title.text = "编辑"
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckView: UIView {
    
    var checkImageView: UIImageView!
    var addressLabel: UILabel!
    
    var id: Int64 = 0
    var clickHandler:(Int64 -> Void)?

    var choosen: Bool = false {
        willSet{
            if newValue {
                self.addressLabel.textColor = UIColor.init(hexString: "#ee304e")
                self.addressLabel.text = "默认地址"
                self.checkImageView.image = UIImage.init(named: "pay_checked")
            } else {
                self.addressLabel.textColor = UIColor.init(hexString: "#333333")
                self.addressLabel.text = "设为默认"
                self.checkImageView.image = UIImage.init(named: "pay_uncheck")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkImageView = UIImageView()
        checkImageView.image = UIImage.init(named: "pay_uncheck")
        self.addSubview(checkImageView)
        checkImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(37.pixelToPoint)
            make.centerY.equalTo(self.snp_centerY)
        }

        addressLabel = UILabel()
        self.addSubview(addressLabel)
        addressLabel.font = UIFont.systemFontOfSize(14)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(checkImageView.snp_right).offset(18.pixelToPoint)
            make.centerY.equalTo(checkImageView)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.setDefault))
        self.addGestureRecognizer(tap)
        self.userInteractionEnabled = true
    }
    
    
    func setDefault() {
        if !choosen {
            self.clickHandler?(id)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddressEditView: UIView {
    
    var imageView: UIImageView!
    var title: UILabel!
    var id: Int64 = 0
    var isDefault: Bool = false
    var clickHandler:((Int64, Bool) -> Void)?
    var tap: UITapGestureRecognizer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        
        title = UILabel()
        title.textColor = UIColor.init(hexString: "#333333")
        title.font = UIFont.systemFontOfSize(14)
        self.addSubview(title)
       
        self.userInteractionEnabled = true
        
        tap = UITapGestureRecognizer.init(target: self, action: #selector(self.click))
        self.addGestureRecognizer(tap!)
        
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(38.pixelToPoint)
            make.centerY.equalTo(self.snp_centerY)
        }
        title.snp_makeConstraints { (make) in
            make.left.equalTo(imageView.snp_right).offset(12.pixelToPoint)
            make.centerY.equalTo(imageView)
        }

    }

    
    
    func click() {
        self.clickHandler?(id, isDefault)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
