//
//  LJHomeViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class LJHomeViewController: LJBaseViewController {

    // 微博数据
    private lazy var statusList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
    }

    // 加载数据
    override func loadData() {
        
        // 用网络工具加载数据
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00hUXEeC31bUKE02e9483882bnmvXE"]
////        LJNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
////
////            print(json ?? "")
////
////        }) { (_, error) in
////
////            print("网络请求失败\(error)")
////        }
//        LJNetworkManager.shared.request(URLString: urlString, parameters:params) { (json, isSuccess) in
//
//            print("网络请求\(json,isSuccess)")
//        }
        
//        LJNetworkManager.shared.statusList { (json) in
//
//            print("加载完成\(String(describing: json))")
//        }
        
        LJNetworkManager.shared.statusList { (list, isSuccess) in
            print(list,isSuccess)
        }
        
        print("加载数据\(LJNetworkManager.shared)")
        // 模拟延时加载数据  - dispatch_after 5秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            for i in 0..<20 {
                if self.isPullUp {
                    self.statusList.append("上拉\(i)")
                } else {
                self.statusList.insert(i.description, at: 0)
                }
            }
            print("刷新表格")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            // 恢复上拉刷新标记
            self.isPullUp = false
            // 刷新表格
            self.tableView?.reloadData()
        }
    }
    
    @objc private func showFriends() {
        print("显示好友")
    }
}
// MARK: - 表格数据源方法,具体的数据源实现方法，不需要super
extension LJHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // 设置cell
        cell.textLabel?.text = self.statusList[indexPath.row]
        // 返回cell
        return cell
    }
    
    
}

// MARK: -设置界面
extension LJHomeViewController {
    
    
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        // 注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
}
