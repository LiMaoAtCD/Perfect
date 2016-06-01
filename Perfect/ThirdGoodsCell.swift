//
//  ThirdGoodsCell.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class ThirdGoodsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var goodImageView: UIImageView!
    var goodTitle: UILabel!
    var chooseButton: UIButton!
    var priceLabel: UILabel!
    var contentLabel: UILabel!
    var deleteButton: UIButton!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        goodImageView = UIImageView()
        self.addSubview(goodImageView)
        
        goodTitle = UILabel()
        self.addSubview(goodTitle)
        
        chooseButton = UIButton.init(type: .Custom)
        self.addSubview(chooseButton)

        priceLabel = UILabel()
        self.addSubview(priceLabel)
        
        
        chooseButton.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(self)
            make.width.height.equalTo(22)
        }
        
        
        
        chooseButton.setImage(UIImage.init(named: "fourtag")!, forState: .Normal)
        goodImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerY.equalTo(self)
            make.left.equalTo(chooseButton.snp_right).offset(8)
            make.bottom.equalTo(-40)
        }
        
        goodImageView.image = UIImage.init(named: "jiu")
        
        goodTitle.snp_makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp_right).offset(10)
            make.centerY.equalTo(goodImageView.snp_top)
        }
        
        goodTitle.text = "商品"
        
        contentLabel = UILabel()
        self.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp_right).offset(8)
            make.right.equalTo(self.snp_right).offset(-50)
        }
        
        contentLabel.text = "容量: 450ml酒精度: 52%"
        
        
        
        
        deleteButton = UIButton()
        self.addSubview(deleteButton)
        deleteButton.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        deleteButton.setImage(UIImage.init(named: "fourtag"), forState: .Normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
