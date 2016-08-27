//
//  HomeTool.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//  首页数据层，用该类去获取数据

import UIKit
import MJExtension

class HomeTool: NSObject {
    
    class func getHomeData(success: (result: HomeResult) -> Void, failure: (error: NSError?) -> Void) {
        // 本地数据、模拟发送请求
        
//        for i in 1...100000000000 {
//            
//        }
        
        // 数据
        let path = Bundle.main.pathForResource("首页焦点按钮", ofType: nil)
        let jsonData = NSData(contentsOfFile: path!)

        let temp: AnyObject = try! JSONSerialization.jsonObject(with: jsonData! as Data, options: [])

        HomeResult.mj_setupObjectClass { () -> [NSObject : AnyObject]? in
            return [
                    "focus": FocusItem.self,
                    "icons": IconsItem.self,
                    "activities": ActivitiesItem.self
                    ]
        }
        let aresult = HomeResult.mj_object(withKeyValues: temp["data"])
        
        success(result: aresult!)
        
        }
    
    class func getHotShopData(success: (result: HomeHotShopResult) -> Void, failure: (error: NSError?) -> Void) {
        //模拟发送请求
        
        //        for i in 1...100000000000 {
        //
        //        }
        
        // 数据
        let path = Bundle.main.pathForResource("首页新鲜热卖", ofType: nil)
        let jsonData = NSData(contentsOfFile: path!)
        
        let temp: AnyObject = try! JSONSerialization.jsonObject(with: jsonData! as Data, options: [])
        
        HomeHotShopResult.mj_setupObjectClass { () -> [NSObject : AnyObject]? in
            return [
                "data": HotShopItem.self,
            ]
        }
        let aresult = HomeHotShopResult.mj_object(withKeyValues: temp)
        
        success(result: aresult!)
        
    }
    
    
}
    
    

