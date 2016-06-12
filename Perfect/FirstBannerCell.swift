//
//  FirstBannerCell.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SnapKit

class FirstBannerCell: UITableViewCell, SDCycleScrollViewDelegate {

    static let identifier = "FirstBannerCell"
    var banner: SDCycleScrollView!
    var titles: [String]?
    var imageURLs: [String]?
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
        banner = SDCycleScrollView.init(frame: self.bounds, delegate: self, placeholderImage: UIImage.init(named: "placeholder")!)
        self.addSubview(banner)
        
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        banner.currentPageDotColor = UIColor.whiteColor()
        
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
