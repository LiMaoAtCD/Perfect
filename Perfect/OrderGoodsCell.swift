//
//  OrderGoodsCell.swift
//  Perfect
//
//  Created by AlienLi on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class OrderGoodsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    var goodImageView: UIImageView!
    var totalLabel: UILabel!
    var mainBgView: UIView!
    var priceLabel: UILabel!
    var statusLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel()
        dateLabel = UILabel()
        mainBgView = UIView()
        goodImageView = UIImageView()
        totalLabel = UILabel()
        priceLabel = UILabel()
        statusLabel = UILabel()
    
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        self.addSubview(mainBgView)
        mainBgView.addSubview(goodImageView)
        mainBgView.addSubview(totalLabel)
        mainBgView.addSubview(priceLabel)
        mainBgView.addSubview(statusLabel)
        
        
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        titleLabel.text = "老酒坊"
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(8)
        }
        
        dateLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(titleLabel)
        }
        
        
        mainBgView.backgroundColor = UIColor.lightGrayColor()
        mainBgView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
            make.height.equalTo(150)
            make.bottom.equalTo(0)
        }
        
        goodImageView.snp_makeConstraints { (make) in
            make.left.equalTo(14)
            make.height.width.equalTo(60)
            make.centerY.equalTo(mainBgView)
        }
        
        goodImageView.image = UIImage.init(named: "banner_goods")
        
        totalLabel.text = "共1种商品"
        totalLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp_right).offset(20)
            make.centerY.equalTo(goodImageView.snp_top)
            
        }
        
        priceLabel.text = "￥25.00"
        priceLabel.textColor = UIColor.redColor()
        priceLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(totalLabel)
        }
        
        statusLabel.text = "已关闭"
        statusLabel.font = UIFont.systemFontOfSize(12.0)
        statusLabel.textColor = UIColor.yellowColor()
        statusLabel.snp_makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp_bottom).offset(8)
            make.right.equalTo(priceLabel)
        }
        
        
        
        
        

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
