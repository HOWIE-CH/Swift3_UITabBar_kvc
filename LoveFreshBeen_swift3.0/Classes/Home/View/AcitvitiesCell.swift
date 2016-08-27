//
//  AcitvitiesCell.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit
import SDWebImage
class AcitvitiesCell: UITableViewCell {

    @IBOutlet weak var activitiesImage: UIImageView!
    var item: ActivitiesItem? {
        didSet {
            
            guard let tempItem = item else {
                return
            }
            let url = URL(string: tempItem.img!)
            activitiesImage.sd_setImage(with: url)
            
            
        }
    }
    
    override var frame: CGRect {
        didSet {
            
            var newFrame = frame
            newFrame.size.height -= 10
            newFrame.size.width -= 20
            newFrame.origin.x += 10
            super.frame = newFrame
            
            
            
        }
    }
    
    
    
    
    
}
