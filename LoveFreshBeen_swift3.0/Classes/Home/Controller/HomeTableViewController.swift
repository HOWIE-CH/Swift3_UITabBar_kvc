//
//  HomeTableViewController.swift
//  LoveFreshBeen_swift3.0
//
//  Created by HOWIE-CH on 16/7/25.
//  Copyright © 2016年 Howie. All rights reserved.
//

import UIKit
import MJRefresh

let activitiesId: String = "activities"
let hotShopId: String = "hot"
class HomeTableViewController: UITableViewController {

    
    var titleView: HomeTitleView?
    var headerView: HomeTableHeaderView?
    var hotCellHeight: Double = 0.0
    lazy var activitiesArray: [ActivitiesItem] = {
       return [ActivitiesItem]()
    }()
    lazy var hotShopArray: [HotShopItem] = {
        return [HotShopItem]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableHeader()
        setupRefresh()
        setupTableView()
    }
    
    private func setupNavigation() {
        

        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "v2_my_avatar_bg"), for: UIBarMetrics.default)
        
        // titleView
        let titleView = HomeTitleView.homeTitleViewCreate()
        titleView.frame.size.width = UIScreen.main().bounds.size.width
        titleView.frame.size.height = (navigationController?.navigationBar.frame.size.height)!
        navigationItem.titleView = titleView
        self.titleView = titleView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.titleView?.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main().bounds.size.width, height: 44.0)

    }
    
    private func setupTableHeader() {
        
        let tableHeader = HomeTableHeaderView.homeTableHeaderCreate()
        tableHeader.frame.size.height = 200.0
        tableView.tableHeaderView = tableHeader
        self.headerView = tableHeader
        
    }
    
    private func setupRefresh() {
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadNewData))
        tableView.mj_header.beginRefreshing()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray()
        tableView.register(UINib(nibName: "AcitvitiesCell", bundle: nil), forCellReuseIdentifier: activitiesId)
        tableView.register(UINib(nibName: "HotShopCell", bundle: nil), forCellReuseIdentifier: hotShopId)
        
    }
    
    func loadNewData() {
        
        //
        HomeTool.getHomeData(success: { (result) in
            // 设置 focus 区域
            let count = result.focus!.count
            var urlArray: [String] = [String]()
            for i in 0..<count {
                let item = (result.focus?[i])! as FocusItem
                urlArray.append(item.img!)
            }
            self.headerView?.pageImgView.imgUrlArray = urlArray
            // 设置button 区域
            self.headerView?.iconItemArray = result.icons!
            // 设置 activities 区域
            self.activitiesArray = result.activities!
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }) { (error) in
            print("error")
            self.tableView.mj_header.endRefreshing()
        }
        
        // hotShop
        HomeTool.getHotShopData(success: { (result) in
  
            self.hotShopArray = result.data!
            // 计算collectionview的 高度
            
            let marginH = CGFloat(25.0)
            let screenW = UIScreen.main().bounds.size.width
            let itemW = ((screenW - 30) * 0.5)
            let itemH = itemW * 1.4
            
            let row = self.hotShopArray.count / 2
            
            self.hotCellHeight = Double (Int(itemH + marginH) * row)
            
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()

        }) { (error) in
            print("error")
            self.tableView.mj_header.endRefreshing()
        }
     }
    
}


// MARK: **** Table view data source ****
extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  section == 0 {
            return activitiesArray.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0 {
            let activitiesCell = tableView.dequeueReusableCell(withIdentifier: activitiesId) as! AcitvitiesCell
            activitiesCell.item = activitiesArray[indexPath.row]
            return activitiesCell
        } else {
            let hotShopCell = tableView.dequeueReusableCell(withIdentifier: hotShopId) as! HotShopCell
            hotShopCell.shopArray = self.hotShopArray
            
            return hotShopCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if   indexPath.section == 0 {
            return 150
        } else {
            return CGFloat(hotCellHeight)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if   section == 0 {
            return 10
        } else {
            return 20
        }

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if   section == 0 {
            return nil
        } else {
            return "新鲜热卖"
        }
    }
    

}
