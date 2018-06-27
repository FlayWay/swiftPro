//
//  LJBaseViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJBaseViewController: UIViewController {

    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义导航条目
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        navigationBar.isHidden = true
    }
    
    override var title: String? {
        
        didSet {
            navItem.title = title
        }
    }
}

// MARK: -界面设置
extension LJBaseViewController {
    
    private func setupUI(){
        view.backgroundColor = UIColor.cz_random()
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
    }
    
}


