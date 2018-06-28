//
//  LJBaseViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJBaseViewController: UIViewController {
    
    // 表格视图 如果用户没有登录 不需要创建
    var tableView:UITableView?
    
    
    /// 自定义导航条
    lazy var navigationBar = LJNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义导航条目
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
}

// MARK: -界面设置
extension LJBaseViewController {
    
    private func setupUI(){
        view.backgroundColor = UIColor.cz_random()
        
        setupNavgationBar()
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


