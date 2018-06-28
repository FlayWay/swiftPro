//
//  LJNavigationController.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // 隐藏默认的导航条
        navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要隐藏
        if childViewControllers.count>0 {
           // 隐藏底部tabBar 
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
