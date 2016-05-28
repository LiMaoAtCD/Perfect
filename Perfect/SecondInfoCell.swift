//
//  SecondInfoCell.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SecondInfoCell: UITableViewCell {

    static let identifier = "SecondInfoCell"
    
    var typeImageView: UIImageView!
    var titleLabel: UILabel!
    var contentLabel: UILabel!
    var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        typeImageView = UIImageView()
        self.addSubview(typeImageView)
        titleLabel = UILabel()
        contentLabel = UILabel()
        dateLabel = UILabel()
        
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(dateLabel)
        
        typeImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.left.equalTo(10)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(typeImageView.snp_right).offset(10)
            make.top.equalTo(20)
        }
        
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
            make.bottom.equalTo(30)
        }
        
        dateLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(titleLabel)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


}
