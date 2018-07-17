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

    // 列表视图模型
    private var listViewModel = LJStatusViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
    }

    // 加载数据
    override func loadData() {
        
//        // 用网络工具加载数据
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00hUXEeCBYYq7D0251603489wetAeC"]
//        LJNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
//
//            print(json ?? "")
//
//        }) { (_, error) in
//
//            print("网络请求失败\(error)")
//        }
//        LJNetworkManager.shared.request(URLString: urlString, parameters:params) { (json, isSuccess) in
//
//            print("网络请求\(json,isSuccess)")
//        }
//
//        LJNetworkManager.shared.statusList { (json) in
//
//            print("加载完成\(String(describing: json))")
//        }
        
//        LJNetworkManager.shared.statusList { (list, isSuccess) in
//            print(list,isSuccess)
//        }
        listViewModel.loadData(pullup:self.isPullUp) { (isSuccess,shouldRefresh) in

            
            print("加载数据\(self.listViewModel.statusList.last?.status.text ?? "")")
            print("\(isSuccess,shouldRefresh)")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            // 恢复上拉刷新标记
            self.isPullUp = false
            if shouldRefresh {
                // 刷新表格
                self.tableView?.reloadData()
            }
        }

    }
    
    @objc private func showFriends() {
        print("显示好友")
    }
}
// MARK: - 表格数据源方法,具体的数据源实现方法，不需要super
extension LJHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LJStatusCell
        // 设置cell
        cell.viewModel = listViewModel.statusList[indexPath.row]
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
        tableView?.register(UINib(nibName: "LJStatusNormalCell", bundle: nil), forCellReuseIdentifier: cellId)
        // 自动布局高度
        tableView?.separatorStyle = .none
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        setupNavTitle()
    }
    
    /// 添加昵称标题
    private func setupNavTitle() {
        let title = LJNetworkManager.shared.userAccount.screen_name
        let button = LJTitleButton(title: title ?? "")
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        navItem.titleView = button
    }
    
   /// 昵称标题按钮点击事件  系统按钮 有图片先显示图片 在显示文字
    @objc private func clickTitleButton(button:UIButton) {
        
        // 设置选中状态
        button.isSelected = !button.isSelected
        
    }
    
}
