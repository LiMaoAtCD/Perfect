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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
