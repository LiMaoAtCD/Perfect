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
        
        self.backgroundColor = UIColor.lightGrayColor()
        
        dateLabel = UILabel()
        self.addSubview(dateLabel)
        dateLabel.text = "2016-06-01"
        dateLabel.textColor = UIColor.blackColor()
        dateLabel.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(dateLabel)
        
        let contentbgView = UIView()
        contentbgView.backgroundColor = UIColor.whiteColor()
        contentbgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        self.addSubview(contentbgView)
        contentbgView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.top.equalTo(dateLabel.snp_bottom).offset(20)
            make.bottom.equalTo(self).offset(-8)
        }
        
        
        titleLabel = UILabel()
        contentbgView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        titleLabel.text = "学习如何使用"
        titleLabel.textColor = UIColor.blackColor()

        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentbgView).offset(8)
            make.right.equalTo(contentbgView).offset(-8)
            make.top.equalTo(contentbgView).offset(20)
        }
        
        timeLabel = UILabel()
        timeLabel.text = "2016-06-01 12:00:00"
        timeLabel.textColor = UIColor.blackColor()

        contentbgView.addSubview(timeLabel)
        timeLabel.font = UIFont.systemFontOfSize(12.0)
        timeLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
        }
        
        contentImageView = UIImageView()
        contentImageView.image = UIImage.init(named: "h6")
        contentbgView.addSubview(contentImageView)
        contentImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(timeLabel.snp_bottom).offset(8)
            make.height.equalTo(100)
        }
        
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.blackColor()

        contentLabel.text = "新闻概念有广义与狭义之分。就其广义而言，除了发表于报刊、广播、互联网、电视上的评论与专文外的常用文本都属于新闻之列，包括消息、通讯、特写、速写"
        
        contentbgView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFontOfSize(12.0)
        contentLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(contentImageView.snp_bottom).offset(8)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        contentbgView.addSubview(line)
        
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(20)
            make.height.equalTo(1)
        }
        
        let readAll = UILabel()
        readAll.text = "阅读全文"
        contentbgView.addSubview(readAll)
        
        readAll.textColor = UIColor.blackColor()
        readAll.font = UIFont.systemFontOfSize(12.0)
        
        readAll.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(line.snp_bottom).offset(8)
            make.bottom.equalTo(contentbgView.snp_bottom).offset(-8)
        }
        
        self.updateConstraintsIfNeeded()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
