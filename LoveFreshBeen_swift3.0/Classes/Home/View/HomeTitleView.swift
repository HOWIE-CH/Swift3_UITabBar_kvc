//
//  HomeTitleView.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class HomeTitleView: UIView {

    class func homeTitleViewCreate() -> HomeTitleView {
        return Bundle.main.loadNibNamed("HomeTitleView", owner: nil, options: nil)[0] as! HomeTitleView
    }

}

extension HomeTitleView {
    
}
