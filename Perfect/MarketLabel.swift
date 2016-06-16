//
//  MarketLabel.swift
//  Perfect
//
//  Created by limao on 16/6/16.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

extension Float {
    var currency: String {
        return "￥\(self)"
    }
}

class MarketLabel: UILabel {

    var line: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        line = UIView.init()
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        
    }
    
    
    var labelColor: UIColor! {
        willSet {
            self.textColor = newValue
            self.line.backgroundColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftConstraint = NSLayoutConstraint.init(item: line, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        let rightConstraint = NSLayoutConstraint.init(item: line, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        let heightConstraint = NSLayoutConstraint.init(item: line, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 1)
        let CenterYConstraint = NSLayoutConstraint.init(item: line, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.addConstraints([leftConstraint, rightConstraint, heightConstraint, CenterYConstraint])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
