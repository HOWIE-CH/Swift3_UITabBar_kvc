//
//  AppDelegate.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /*
         shopCart
         v2_home
         v2_my
         v2_order
         */
        
        window = UIWindow(frame: UIScreen.main().bounds)
        let tabVc = TabBarViewController()
        tabVc.delegate = self
        
        window?.rootViewController = tabVc
        window?.makeKeyAndVisible()
        
        
        
        return true
    }


}


// MARK: **** UITabBarControllerDelegate ****
extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        for view  in tabBarController.tabBar.subviews {
            if view.isKind(of: NSClassFromString("UITabBarButton")! ) {
                // UITabBarButton是继承UIControl的， 通过 按钮的状态 才判别是否是现在点击的按钮
                let state = view.value(forKeyPath: "highlighted")
                let stateValue = state as! Int
                if stateValue == 1 {
                    // 拿到当前点击的 按钮的imageView
                    let imageView = view.value(forKeyPath: "_info")
                    guard let temp  = imageView else {
                        return
                    }
                    
                    let tabButtonImgView = temp as! UIImageView
                    // 添加动画
                    UIView.animate(withDuration: 0.2, animations: {
                        tabButtonImgView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        }, completion: { (Bool) in
                            tabButtonImgView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    })
                }
            }
        }
   
    }
    
}

