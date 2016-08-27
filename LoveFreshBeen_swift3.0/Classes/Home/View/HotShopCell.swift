//
//  HotShopCell.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit


let shopCellId = "shop"
class HotShopCell: UITableViewCell {
    @IBOutlet weak var flow: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var shopCellHeight: Double = 0.0
    var shopArray: [HotShopItem] = [HotShopItem]() {
        didSet {
            
            
            
            
            collectionView.reloadData()
            shopCellHeight =  Double(collectionView.contentSize.height)
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flow.minimumLineSpacing = 25
        let screenW = UIScreen.main().bounds.size.width
        let itemW = (screenW - 30) * 0.5
        let itemH = itemW * 1.4
        flow.itemSize = CGSize(width: itemW, height: itemH)
        
        collectionView.register(UINib(nibName: "ShopCell", bundle: nil), forCellWithReuseIdentifier: shopCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.lightGray()

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

extension HotShopCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopCellId, for: indexPath) as! ShopCell
        
        cell.item = shopArray[indexPath.row]
        
        return cell
    }
    
    // 这里collectionview的所有cell 是同时创建的，整个collectionview在一tableView的cell 里
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("aaaaaaaaaaaaa\(indexPath)")
        cell.transform = CGAffineTransform(translationX: 0, y: 80)
        UIView.animate(withDuration: 1) {
            cell.transform = CGAffineTransform.identity
        }
        
    }
   
    
    
}
