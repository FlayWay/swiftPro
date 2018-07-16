//
//  LJMainViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import SVProgressHUD

class LJMainViewController: UITabBarController {

    // 定时器
    private var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupcomposeBtn()
        setupTimer()
        
        setupNewFeature()
        
        // 设置代理
        delegate = self
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogIn), name: NSNotification.Name(rawValue: LJUserShouldloginNotification), object: nil)
        
        
    }
    
    deinit {
        
        // 销毁时钟
        timer?.invalidate()
        // 注销通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
    // 用户登录
   @objc private func userLogIn(n:Notification){
        print(n)
    if n.object != nil {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "用户登录已经超时，请重新登录")
    }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
    
        SVProgressHUD.setDefaultMaskType(.clear)
        // 展现登录控制器，通常会和 UINavigationController连用
        let vc = LJOAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
     }
    
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
        
        // 获取沙河路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                         .userDomainMask,
                                                         true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        var data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        // 从bundle 加载配置的 json
        guard  let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as! [[String:Any]]  else {
            return
        }
//        let array:[[String:Any]] = [
//            ["clsName":"LJHomeViewController","title":"首页","imageName":"home","visitorInfo":["imageName":"","message":"关注一些人,回这里看看有什么变化"]],
//            ["clsName":"LJMessageViewController","title":"消息","imageName":"message_center","visitorInfo":["imageName":"visitordiscover_image_message","message":"登录后,别人评论你的微博,发给你的消息,都会在这里收到通知"]],
//            ["clsName":"UIViewController"],
//            ["clsName":"LJDiscoverViewController","title":"发现","imageName":"discover","visitorInfo":["imageName":"visitordiscover_image_message","message":"登录后,最新最热微博尽在掌握,不再会与实时潮流擦肩而过"]],
//        ["clsName":"LJProfileViewController","title":"我","imageName":"profile","visitorInfo":["imageName":"visitordiscover_image_profile","message":"登录后,你的微博、相册、个人资料会显示到这里,展示给别人"]]
//                     ]
        
        // json 写入到沙河  数组 -- > 序列化
//        (array as NSArray).write(toFile: "/Users/ljkj/Desktop/demo.plist", atomically: true)
//        let data = try? JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data! as NSData).write(toFile: "/Users/ljkj/Desktop/demo.json", atomically: true)
        
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
        let w = tabBar.bounds.width/count
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        print("按钮宽度\(composeBtn.bounds.width)")
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
}


// MARK: - 定义时钟相关
extension LJMainViewController {
    
    // 时钟初始化
    private func setupTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 600.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //
   @objc private func updateTimer() {
    
        print(#function)
        LJNetworkManager.shared.unreadCount { (count) in
            // 设置 首页  tabbarItem的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            // 设置APP的badgeNumber  从ios8之后，需要用户授权才能显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}


// MARK: - UITabBarControllerDelegate
extension LJMainViewController:UITabBarControllerDelegate {
    
    
    /// 将要选择tabBaritem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 就不需要容错点了
        print("将要切换到\(viewController)")
        let isMess = viewController.isMember(of: UIViewController.self)
        print("控制器\(isMess)")
        
        // 获取控制器在controllers中索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        // 判断当前索引是首页，同时idx 也是首页，重复点击首页的按钮
        
        if selectedIndex == 0 && idx == selectedIndex  {
            print("点击首页")
            // 让表格滚动到顶部
            // 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! LJHomeViewController
            // 滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            // 刷新表格
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
                vc.loadData()
            })
            // 清除value
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        return !viewController.isMember(of: UIViewController.self)
    }
    
}


// MARK: - 新特性视图
extension LJMainViewController {
    
    /// 新特性视图
    private func setupNewFeature() {
       
        // 判断是否登录
        if !LJNetworkManager.shared.userLogin {
            
            return
        }
        
        // 1、检查版本更新
       
        // 2、如果更新，显示新特性
        let v = isNewVersion ? LJNewFeatureView.newFeatureView() : LJWelcomeView.welcomeView()
        // 3、添加视图
        v.frame = view.bounds
        view.addSubview(v)
        
    }
    
    
    /// extension 可以有计算型属性，不占用存储空间
    /// 构造函数：给属性分配空间
    private var isNewVersion:Bool {
        
        // 取当前的版本号
//        print(Bundle.main.infoDictionary)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        print(currentVersion)
        // 取itunes中版本号
        let path:String = (currentVersion as NSString).cz_appendDocumentDir()
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        print(sandboxVersion)
        
        // 将当前版本号保存沙河
       try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        // 两个版本号是否一致
        return currentVersion != sandboxVersion
    }
    
}
