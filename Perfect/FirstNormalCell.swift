//
//  FirstNormalCell.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class FirstNormalCell: UITableViewCell {

    static let identifier = "FirstNormalCell"

    
    var contentImageView: UIImageView!
    
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
        contentImageView = UIImageView()
        self.addSubview(contentImageView)
        
        contentImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
