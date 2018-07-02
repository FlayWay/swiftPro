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
    
    // 设置屏幕方向 当前的控制器和子控制器都会遵守这个方向
    // 如果是视频 一般是通过modal 来展示的
    /// portrait 竖屏 肖像
    /// landscape 横屏 风景
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: -撰写按钮事件
   @objc private func composeStatus() {
        print("撰写事件")
        let vc = UIViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
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
    // 在现在的很多应用程序中，界面的创建都依赖网络的 json
    private func setupChildControllers() {
        let array:[[String:Any]] = [
            ["clsName":"LJHomeViewController","title":"首页","imageName":"home","visitorInfo":["imageName":"","message":"关注一些人,回这里看看有什么变化"]],
            ["clsName":"LJMessageViewController","title":"消息","imageName":"message_center","visitorInfo":["imageName":"visitordiscover_image_message","message":"登录后,别人评论你的微博,发给你的消息,都会在这里收到通知"]],
            ["clsName":"UIViewController"],
            ["clsName":"LJDiscoverViewController","title":"发现","imageName":"discover","visitorInfo":["imageName":"visitordiscover_image_message","message":"登录后,最新最热微博尽在掌握,不再会与实时潮流擦肩而过"]],
        ["clsName":"LJProfileViewController","title":"我","imageName":"profile","visitorInfo":["imageName":"visitordiscover_image_profile","message":"登录后,你的微博、相册、个人资料会显示到这里,展示给别人"]]
                     ]
        
        // json 写入到沙河  数组 -- > 序列化
//        (array as NSArray).write(toFile: "/Users/ljkj/Desktop/demo.plist", atomically: true)
        let data = try? JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        (data! as NSData).write(toFile: "/Users/ljkj/Desktop/demo.json", atomically: true)
        
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
    private func controller(dict:[String:Any]) -> UIViewController {
        
        // 取得字典内容
        guard let clsName = dict["clsName"] as? String,
              let  title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? LJBaseViewController.Type,
        let visitor = dict["visitorInfo"] as? [String:String]
        else {
            
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        // 访客视图的字典
        vc.visitorInfoDiction = visitor
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

