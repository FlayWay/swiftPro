//
//  LJBaseViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

/// 所有主控制器的基类控制器
class LJBaseViewController: UIViewController {
    
    /// 用户登录标记
    var userLog = false
    // 表格视图 如果用户没有登录 不需要创建
    var tableView:UITableView?
    /// 刷新控件
    var refreshControl:UIRefreshControl?
    /// 上拉刷新标记
    var isPullUp = false
    /// 自定义导航条
    lazy var navigationBar = LJNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义导航条目
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
    
    /// 加载数据  - 具体的实现由子类负责
    @objc func loadData()  {
        // 如果子类不实现任务方法，默认关闭刷新
        refreshControl?.endRefreshing()
    }
}

// MARK: -界面设置
extension LJBaseViewController {
    
    private func setupUI(){
        view.backgroundColor = UIColor.white
        setupNavgationBar()
        
        userLog ? setupTableView() : setupVisitorView()
        
        // 取消自动缩放
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        };
    }
    /// 设置表格视图
    private func setupTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        // 设置数据源代理 -> 子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        view.insertSubview(tableView!, belowSubview:navigationBar)
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        // 设置刷新控件
        // 实例化控件
        refreshControl = UIRefreshControl()
        // 添加到视图
        tableView?.addSubview(refreshControl!)
        // 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
    }
    
    /// 设置访客视图
    private func setupVisitorView(){
        
        let visitorView = LJVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
    }
    
    /// 设置导航条
    private func setupNavgationBar(){
     
        // 添加到航条
        view.addSubview(navigationBar)
        // 将item设置给Bar
        navigationBar.items = [navItem]
        // 设置navbar的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 设置navBar的字体颜色
        navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
    }
    
}

// MARK: - tableView代理方法
extension LJBaseViewController: UITableViewDataSource,UITableViewDelegate {
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据方法，不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    /// 在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 判断indexPath 是否是最后一行 indexPath section 最大 indexPath.row 最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            
            return
        }
        
        // 行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count-1) && !isPullUp {
            
            print("上拉刷新")
            isPullUp = true
            // 开始刷新
            loadData()
        }
        
    }
}


