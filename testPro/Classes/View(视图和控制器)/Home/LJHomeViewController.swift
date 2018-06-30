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
        setupUI()

    }

    // 加载数据
    
    override func loadData() {
        
        print("加载数据")
        // 模拟延时加载数据  - dispatch_after 5秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            for i in 0..<20 {
                self.statusList.insert(i.description, at: 0)
            }
            print("刷新表格")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
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
    private func setupUI() {
    
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
}
