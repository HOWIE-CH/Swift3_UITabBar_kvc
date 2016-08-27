//
//  TabBarViewController.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    // 懒加载
    private var itemArray: [UITabBarItem] = {
        return [UITabBarItem]()
    }()
    var shopCartButton: VerticalButton?
    
    // 全局样式
    override class func initialize() {
        
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.lightGray()
        
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState.normal)
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState.selected)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for button in tabBar.subviews {
            
            if button.isKind(of: NSClassFromString("UITabBarButton")! ) {
                let label = button.value(forKeyPath: "_label") as! UILabel
                //  print("\(label.text)")
                if label.text == "" {
                    
                    let badgeButton = button.value(forKeyPath: "_badge")
                    //   print("\(badgeButton!.self)")
                    guard let badgeView = badgeButton else {
                        return
                    }
                    
                    let badge = badgeView as! UIView
                    //  print("\(badge.subviews)")
                    badge.frame.origin.x = 52
  
                }
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllChildController()
        setupTabBar()
    }
    
    private func setupAllChildController() {
        let home = HomeTableViewController(style: UITableViewStyle.grouped)
        setupOneChildController(viewController: home, image: UIImage.diy_imgOriginalWithImgName(imageName: "v2_home"), seletedImage: UIImage.diy_imgOriginalWithImgName(imageName: "v2_home_r") , title: "首页")
        
        let order = OrderTableViewController()
        setupOneChildController(viewController: order, image: UIImage.diy_imgOriginalWithImgName(imageName: "v2_order"), seletedImage: UIImage.diy_imgOriginalWithImgName(imageName: "v2_order_r"), title: "闪电超市")
        
        
        // shopCart 是modal 出来的 
        
//        let shopCart = ShopCartTableViewController()
//        setupOneChildController(viewController: shopCart, image: UIImage.diy_imgOriginalWithImgName(imageName: "shopCart"), seletedImage: UIImage.diy_imgOriginalWithImgName(imageName: "shopCart_r"), title: "购物车")
        
        let vc = UIViewController()
        
        setupOneChildController(viewController: vc, image: UIImage(), seletedImage: UIImage(), title: "")
        vc.tabBarItem.isEnabled = false
        vc.tabBarItem.badgeValue = "1"
        
        
        
        
        let my = MyTableViewController()
        setupOneChildController(viewController: my, image: UIImage.diy_imgOriginalWithImgName(imageName: "v2_my"), seletedImage: UIImage.diy_imgOriginalWithImgName(imageName: "v2_my_r"), title: "我")
        
    }
    
    private func setupOneChildController(viewController: UIViewController, image: UIImage, seletedImage: UIImage, title: String) {
        
        viewController.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = seletedImage
        
        
        itemArray.append(viewController.tabBarItem)
        
        let nav: NavigationViewController = NavigationViewController(rootViewController: viewController)
        
        addChildViewController(nav)
 
    }
    
    private func setupTabBar() {
        
        let shopCartButton = VerticalButton(type: UIButtonType.custom)
        shopCartButton.setImage(UIImage.diy_imgOriginalWithImgName(imageName: "shopCart"), for: UIControlState.normal)
        shopCartButton.setImage(UIImage.diy_imgOriginalWithImgName(imageName: "shopCart_r"), for: UIControlState.highlighted)
        shopCartButton.setTitle("购物车", for: UIControlState.normal)
        shopCartButton.addTarget(self, action: #selector(TabBarViewController.shopCartButtonClick(button:)), for: UIControlEvents.touchUpInside)
        shopCartButton.sizeToFit()
        
        let btnX = tabBar.frame.size.width / 4.0 * 2 + tabBar.frame.size.width / 4.0 * 0.5
        let btnY = tabBar.frame.size.height * 0.73
 
        shopCartButton.center = CGPoint(x: btnX, y: btnY)
//        tabBar.addSubview(shopCartButton)
        tabBar.insertSubview(shopCartButton, at: 0)
        self.shopCartButton = shopCartButton
        
        
    }
    
    func shopCartButtonClick(button: VerticalButton) {
        
        
//        // 把其他的tabbutton 取消选中
//        for temp  in tabBar.subviews {
//            
//            if temp.isKind(of: NSClassFromString("UITabBarButton")! ) {
//                
//                let button: UIControl = temp as! UIControl
//                button.isHighlighted = false
//                button.isSelected = false
//            }
//        }
//        
        
        let shopCart = ShopCartViewController()
        
        
        let vc = selectedViewController!
        let nav = NavigationViewController(rootViewController: shopCart)
        
        vc.present(nav, animated: true, completion: nil)
        
        
    }
    
    
}
