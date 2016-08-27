//
//  HomeTableHeaderView.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UIView {

    @IBOutlet weak var pageImgView: DIYPageImgView!
    @IBOutlet weak var firstButton: IconButton!
    @IBOutlet weak var secondButton: IconButton!
    @IBOutlet weak var thirdButton: IconButton!
    @IBOutlet weak var lastButton: IconButton!
    
     var iconItemArray: [IconsItem]? {
        didSet{
            guard let tempArray = iconItemArray else {
                return
            }
            
            firstButton.item = tempArray[0]
            secondButton.item = tempArray[1]
            thirdButton.item = tempArray[2]
            lastButton.item = tempArray[3]
            
        }
        
    }
    
    
    class func homeTableHeaderCreate() -> HomeTableHeaderView {
        return Bundle.main.loadNibNamed("HomeTableHeaderView", owner: nil, options: nil)![0] as! HomeTableHeaderView
    
    }

}
