//
//  LJCommon.swift
//  testPro
//
//  Created by ljkj on 2018/7/10.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation


/// 应用程序ID
let LJAppKey = "4219554302"
/// 应用程序加密信息
let LJAppSecret = "4172d8d0e55be83eb13540823cf49cd3"
/// 应用程序回调地址
let ljAppDirectUrl = "http://www.baidu.com"

/// 用户登录需要通知
let LJUserShouldloginNotification = "LJUserShouldloginNotification"

/// 用户登录成功通知
let LJUserloginSuccessNotification = "LJUserloginSuccessNotification"

/// 常数设置
let LJStatusPictureOutterMargin = CGFloat(12)
/// 内部图像间距
let LJStatusPictureInnerMargin = CGFloat(3)
/// 视图宽度
let LJStatusPictureWidth = UIScreen.cz_screenWidth() - 2*LJStatusPictureOutterMargin
/// 图片Item默认宽度
let LJStatusPictureItemWidth = (LJStatusPictureWidth - 2 * LJStatusPictureInnerMargin)/3
