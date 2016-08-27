//
//  UIImage.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

extension UIImage {
    
    
     class  func diy_imgResizingWithImgName(imageName: String) -> UIImage {
        let image = UIImage(named: imageName)!
        return image.resizableImage(withCapInsets: UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5 - 1, image.size.width * 0.5 - 1), resizingMode: UIImageResizingMode.tile)

    }
    
     class  func diy_imgOriginalWithImgName(imageName: String) -> UIImage {
        let image = UIImage(named: imageName)!
        return image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    
    
    
    
}
