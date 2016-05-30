//
//  SecondDetailTableViewCell.swift
//  Perfect
//
//  Created by limao on 16/5/30.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SecondDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var titleLabel: UILabel!
    var contentLabel: UILabel!
    var dateLabel: UILabel!
    var timeLabel: UILabel!

    var contentImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(titleLabel)
        
        contentLabel = UILabel()
        self.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(contentLabel)
        
        contentImageView = UIImageView()
        self.addSubview(contentImageView)
        
        dateLabel = UILabel()
        self.addSubview(dateLabel)
        dateLabel.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(dateLabel)
        
        timeLabel = UILabel()
        self.addSubview(timeLabel)
        timeLabel.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(timeLabel)

        dateLabel.snp_makeConstraints { (make) in
            make.top.equalTo(8)
            make.centerX.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
