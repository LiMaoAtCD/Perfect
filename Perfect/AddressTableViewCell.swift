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
    
    var name: UILabel!
    var address: UILabel!
    var cellphone: UILabel!
    var deleteButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name = UILabel()
        cellphone = UILabel()
        address = UILabel()
        deleteButton = UIButton.init(type: .Custom)
        
        self.addSubview(name)
        self.addSubview(cellphone)
        self.addSubview(address)
        self.addSubview(deleteButton)
        
        name.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(14)
            make.width.greaterThanOrEqualTo(50)
        }
        cellphone.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right)
            make.centerY.equalTo(name)
            make.right.equalTo(self)
        }
        
        cellphone.textAlignment = .Left
        
        address.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp_bottom).offset(14)
            make.right.equalTo(self)
            make.bottom.equalTo(-8)
        }
        
        deleteButton.setTitle("删除", forState: .Normal)
        deleteButton.snp_makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(35)
            make.right.equalTo(self).offset(-8)
            make.centerY.equalTo(self)
        }
        
        
        name.text = "我"
        address.text =  "四川省成都市"
        cellphone.text = "18911113232"
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
