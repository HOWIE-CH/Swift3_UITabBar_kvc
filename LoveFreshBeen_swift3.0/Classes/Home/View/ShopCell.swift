//
//  ShopCell.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit
import SDWebImage
class ShopCell: UICollectionViewCell {
    
    var item: HotShopItem? {
        didSet {
           
            guard let tempItem = item else {
                return
            }
            
            // 赋值
            let url = URL(string: tempItem.img!)


            img.sd_setImage(with: url) { [unowned self] (image: UIImage?, error: NSError?, cacheType: SDImageCacheType, url: URL?) in
                
                guard let tempImag = image else {
                    return
                }
                
                // 处理图片
                UIGraphicsBeginImageContextWithOptions(self.img.frame.size, false, 0.0)
                
                let imgW = tempImag.size.width
                let imgH = tempImag.size.height
                
                let resultW = self.img.frame.size.width
                let resultH = resultW * imgH / imgW
                
                tempImag.draw(in: CGRect(x: 0, y: 0, width: resultW, height: resultH))
                self.img.image = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                
                
            }
            name.text = tempItem.name!
            specifics.text = tempItem.specifics!
            
            // buyone hidden
            if  tempItem.pm_desc != "" {
                buyOne.isHidden = false
            } else {
                buyOne.isHidden = true
            }

            num = 0
        }
    }
    
    var snapView: UIView?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var specifics: UILabel!
    @IBOutlet weak var buyOne: UIImageView!
    @IBOutlet weak var count: UILabel!
    var num: Int = 0 {
        didSet {
            // 减号、 个数
            if  num != 0 {
                reduce.isHidden = false
                count.isHidden = false
            } else {
                reduce.isHidden = true
                count.isHidden = true
                
            }
            count.text = "\(num)"
        }
    }
    @IBOutlet weak var reduce: UIButton!
    @IBOutlet weak var increase: UIButton!
    
    @IBAction func increaseClick(_ sender: AnyObject) {
       
        if  num >= (item!.number! as NSString).integerValue {
            print("000000")
            return
        }
        
        num += 1
        reduce.isEnabled = true
        
        // 按钮的动画
        
        let tab = window?.rootViewController as! TabBarViewController
        
        for button in tab.tabBar.subviews {
            
            if button.isKind(of: NSClassFromString("UITabBarButton")! ) {
                let label = button.value(forKeyPath: "_label") as! UILabel
                // 外界通过 lable.text 区别出是我们需要的 第三个UITabBarButton
                if label.text == "" {
                    let badgeButton = button.value(forKeyPath: "_badge")
                    guard let badgeView = badgeButton else {
                        return
                    }
                    // 拿到 badge 控件
                    let badge = badgeView as! UIView
                    //  num变量为 点击加号按钮， 商品个数 计量
                    let str:NSString = NSString.init(format: "%d", num)

                    // kvc 设置属性
                    badgeView.setValue(UIFont.systemFont(ofSize: 9), forKeyPath: "_label.font")
                    badgeView.setValue(str, forKeyPath: "_label.text")
                    
                    let tabLabal = badgeView.value(forKeyPath: "_label")
                    let label = tabLabal as! UILabel
                    // 拿到lebel 计算label 的大小、尺寸
                    let size = str.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 9)])
                    label.frame = CGRect(x: (badge.frame.size.width - size.width) * 0.5, y: (badge.frame.size.height - size.height) * 0.5, width: size.width, height: size.height)
                    // 添加核心动画
                    let scaleAni =  CABasicAnimation()
                    scaleAni.keyPath = "transform.scale"
                    scaleAni.fromValue = 1.0
                    scaleAni.toValue = 1.2
                    scaleAni.autoreverses = true
                    scaleAni.duration = 0.25
                    badge.layer.add(scaleAni, forKey: nil)
                    
                }
            }
        }
        
    }
    
    @IBAction func reduceClick(_ sender: AnyObject) {
        num -= 1
    }

}


