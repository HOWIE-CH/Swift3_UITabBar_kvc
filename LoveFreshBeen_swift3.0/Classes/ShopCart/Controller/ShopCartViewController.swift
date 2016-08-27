//
//  ShopCartViewController.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit

class ShopCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "购物车"
        
        view.backgroundColor = UIColor.white()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.diy_imgOriginalWithImgName(imageName: "v2_goback"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ShopCartViewController.leftBtnClick))
        
        // Do any additional setup after loading the view.
    }
    
    func leftBtnClick() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
