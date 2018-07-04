//
//  LJNetworkManager.swift
//  testPro
//
//  Created by ljkj on 2018/7/4.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import AFNetworking

// 导入第三方库的名字
// 网络管理工具
class LJNetworkManager: AFHTTPSessionManager {

    // 静态区、常量、闭包
    // 在第一次访问的时候，执行闭包，并且将结果保存在 shared 常量中
    static let shared = LJNetworkManager()
}
