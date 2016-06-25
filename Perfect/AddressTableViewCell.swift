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
            make.bottom.equalTo(self).offset(-10)
        }
        
        
        name = UILabel()
        MainView.addSubview(name)
        name.font = UIFont.systemFontOfSize(15)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(14)
            make.width.greaterThanOrEqualTo(50)
        }
        
        cellphone = UILabel()
        MainView.addSubview(cellphone)
        cellphone.snp_makeConstraints { (make) in
            make.right.equalTo(MainView.snp_right).offset(-20)
            make.baseline.equalTo(name.snp_baseline)
        }
        cellphone.textAlignment = .Right

        
        address = UILabel()
        MainView.addSubview(address)
        address.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp_bottom).offset(14)
            make.right.equalTo(self)
        }

        marginView = UIView()
        marginView.backgroundColor = UIColor.grayColor()
        MainView.addSubview(marginView)
        marginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(1)
            make.top.equalTo(address.snp_bottom).offset(20)
        }
        
        
        defaultAddress = CheckView()
        MainView.addSubview(defaultAddress)
        defaultAddress.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.width.lessThanOrEqualTo(100)
            make.top.equalTo(marginView.snp_bottom).offset(14)
            make.height.equalTo(35)
            make.bottom.equalTo(MainView.snp_bottom).offset(-14)
        }
        
        deleteView = AddressEditView()
        MainView.addSubview(deleteView)
        deleteView.snp_makeConstraints { (make) in
            make.right.equalTo(cellphone)
            make.centerY.equalTo(defaultAddress)
            make.width.greaterThanOrEqualTo(80)
        }
        deleteView.imageView.image = UIImage.init(named: "perfect")
        deleteView.title.text = "删除"
        
        editView = AddressEditView()
        
        MainView.addSubview(editView)
        editView.snp_makeConstraints { (make) in
            make.right.equalTo(deleteView.snp_left).offset(-14)
            make.centerY.equalTo(defaultAddress)
            make.width.greaterThanOrEqualTo(80)
        }
        editView.imageView.image = UIImage.init(named: "perfect")
        editView.title.text = "编辑"
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckView: UIView {
    
    var checkImageView: UIImageView!
    var addressLabel: UILabel!
    
    var choosen: Bool = false {
        willSet{
            if newValue {
                self.addressLabel.textColor = UIColor.redColor()
                self.checkImageView.image = UIImage.init(named: "perfect")
            } else {
                self.addressLabel.textColor = UIColor.blackColor()
                self.checkImageView.image = UIImage.init(named: "perfect")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkImageView = UIImageView()
        self.addSubview(checkImageView)
        checkImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self.snp_centerY)
        }

        addressLabel = UILabel()
        self.addSubview(addressLabel)
        addressLabel.text = "默认地址"
        addressLabel.font = UIFont.systemFontOfSize(14)
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(checkImageView.snp_right).offset(14)
            make.centerY.equalTo(checkImageView)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.setDefault))
        self.addGestureRecognizer(tap)
    }
    
    var clickHandler:(Void -> Void)?
    
    func setDefault() {
        self.clickHandler?()
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
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.height.equalTo(25)
            make.centerY.equalTo(self.snp_centerY)
        }
        imageView.userInteractionEnabled = true
        
        title = UILabel()
        title.textColor = UIColor.flatGrayColor()
        self.addSubview(title)
        title.font = UIFont.systemFontOfSize(14)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(imageView.snp_right).offset(14)
            make.centerY.equalTo(imageView)
        }
        title.userInteractionEnabled = true
        
        tap = UITapGestureRecognizer.init(target: self, action: #selector(self.click))
        title.addGestureRecognizer(tap!)
        imageView.addGestureRecognizer(tap!)
        self.userInteractionEnabled = true
        title.backgroundColor = UIColor.redColor()
    }
    
    
    func click() {
        self.clickHandler?(id, isDefault)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
