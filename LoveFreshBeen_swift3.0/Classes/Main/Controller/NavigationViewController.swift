//
//  NavigationViewController.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        
        
    }
    // 重写initialize 方法    该方法没有提示
    override class func initialize() {
        
    }
    
    // 重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if  childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    

    
}

// MARK: **** 手势代理 ****
extension NavigationViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if childViewControllers.count >= 1 {
            return false
        }
        return true
    }
}
