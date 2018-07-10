//
//  AppDelegate.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 取得用户授权显示通知 available 检查设备版本 如果是10.0以上 执行
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound,.carPlay], completionHandler: { (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            })
        }else {
            let notification = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notification)
        }
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = LJMainViewController()
        window?.makeKeyAndVisible()
        loadAppInfo()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// MARK: - 从服务器加载应用程序
extension AppDelegate {
    
    func loadAppInfo() {
        
        DispatchQueue.global().async {
            
            let url =  Bundle.main.url(forResource: "main.json",
                                       withExtension: nil)
            let data = NSData(contentsOf: url!)
            // 写入沙河
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask,
                                                            true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            data?.write(toFile: jsonPath, atomically: true)
            print("应用程序加载完毕\(jsonPath)")
        }
    }
}


