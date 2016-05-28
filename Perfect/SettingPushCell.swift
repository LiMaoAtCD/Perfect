//
//  SettingPushCell.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SettingPushCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tagImageView: UIImageView!
    var title: UILabel!
    var switcher: UISwitch!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tagImageView = UIImageView()
        self.addSubview(tagImageView)
        tagImageView.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        title = UILabel()
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(tagImageView.snp_right).offset(8)
            make.centerY.equalTo(tagImageView)
        }
        
        switcher = UISwitch()
        self.addSubview(switcher)
        switcher.snp_makeConstraints { (make) in
            make.right.equalTo(-14)
            make.width.equalTo(40)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
