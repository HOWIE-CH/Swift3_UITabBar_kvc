//
//  IconButton.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class IconButton: VerticalButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.size.width = self.frame.size.width
        imageView?.frame.size.height = self.frame.size.height - (titleLabel?.frame.size.height)!
        
        imageView?.center.x = self.frame.size.width * 0.5
        imageView?.frame.origin.y = (titleLabel?.frame.origin.y)! - (imageView?.frame.size.height)!
    }

}
