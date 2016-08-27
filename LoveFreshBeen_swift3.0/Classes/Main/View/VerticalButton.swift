//
//  VerticalButton.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit
import SDWebImage
class VerticalButton: UIButton {
    
    
    var item: IconsItem? {
        didSet {
            guard let iconItem = item else {
                return
            }
            
            self.setTitle(iconItem.name, for: UIControlState.normal)
            let url = NSURL(string: iconItem.img!)
            self.sd_setImage(with: url! as URL!, for: UIControlState.normal)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        imageView?.contentMode = UIViewContentMode.center
        setTitleColor(UIColor.lightGray(), for: UIControlState.normal)
        setTitleColor(UIColor.lightGray(), for: UIControlState.highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        // titleLabel
        titleLabel?.sizeToFit()
        titleLabel?.center.x = self.frame.size.width * 0.5
        titleLabel?.frame.origin.y = self.frame.size.height - (titleLabel?.frame.size.height)!
        // imageView
        
        imageView?.sizeToFit()
//        imageView?.frame.size.width = self.frame.size.width
//        imageView?.frame.size.height = self.frame.size.height - (titleLabel?.frame.size.height)!
        imageView?.center.x = self.frame.size.width * 0.5
        imageView?.frame.origin.y = (titleLabel?.frame.origin.y)! - (imageView?.frame.size.height)!
        
    }
    
    
    
}
