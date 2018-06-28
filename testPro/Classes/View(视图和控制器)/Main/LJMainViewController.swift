//
//  LJMainViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupcomposeBtn()
    }
    
    // MARK: -撰写按钮事件
   @objc private func composeStatus() {
        print("撰写事件")
    }
    
    
    // MARK: - 私有控件
    private lazy var composeBtn:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName:"tabbar_compose_button")
    
}

// extension 类似于 oc中的分类，在swift还可以用来切分代码块
// 可以把相近功能的代码块放到一个extension
// 便于代码维护
// 注意: extension 不能定义属性
// MARK: - 设置界面
extension LJMainViewController {
    
    /// 设置所有的自控制器
    private func setupChildControllers() {
        let array = [
            ["clsName":"LJHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"LJMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"UIViewController"],
            ["clsName":"LJDiscoverViewController","title":"发现","imageName":"discover"],
        ["clsName":"LJProfileViewController","title":"我","imageName":"profile"]
                     ]
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    /// 使用字典创建一个自控制器
    ///
    /// - Parameter dict: 信息字典[clsName,title,imageName]
    /// - Returns: 子控制器
    private func controller(dict:[String:String]) -> UIViewController {
        
        // 取得字典内容
        guard let clsName = dict["clsName"],
              let  title = dict["title"],
              let imageName = dict["imageName"],
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
        else {
            
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = LJNavigationController(rootViewController: vc)
    vc.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.orange], for: .highlighted)
        // 系统默认是12号字体 修改字体大小 设置为默认
    vc.tabBarItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 14)], for: .normal)
    
        return nav
    }
    
    // 设置撰写按钮
    private  func setupcomposeBtn(){
        
        tabBar.addSubview(composeBtn)
        
        // 计算按钮的frame
        guard let vcs = viewControllers else {
            return
        }
        let count = CGFloat(vcs.count)
        // 容错点
        let w = tabBar.bounds.width/count - 1
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        print("按钮宽度\(composeBtn.bounds.width)")
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
}

