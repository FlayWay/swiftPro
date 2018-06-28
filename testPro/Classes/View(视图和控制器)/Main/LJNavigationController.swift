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
        
        // 判断控制器的类型
        if let vc = viewController as? LJBaseViewController  {
            
            var title = "返回"
            if childViewControllers.count == 1 {
                // title显示首页的标题
                title = childViewControllers.first?.title ?? "返回"
            }
            
            // 取出自定义的navItem
            vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToparent), isBackButton: true)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // POP 返回到上一个页面
   @objc private func popToparent(){
        popViewController(animated: true)
    }

}
