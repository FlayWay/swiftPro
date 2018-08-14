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


// MARK: ----照片浏览通知
let LJStatusCellBrowserPhotoNotification = "LJStatusCellBrowserPhotoNotification"

let LJStatusCellBrowserPhotoSelectedIndexKey = "LJStatusCellBrowserPhotoSelectedIndexKey"

let LJStatusCellBrowserPhotoImageViewsKey = "LJStatusCellBrowserPhotoImageViewsKey"

let LJStatusCellBrowserPhotoUrlsKey = "LJStatusCellBrowserPhotoUrlsKey"

/// 常数设置
let LJStatusPictureOutterMargin = CGFloat(12)
/// 内部图像间距
let LJStatusPictureInnerMargin = CGFloat(3)
/// 视图宽度
let LJStatusPictureWidth = UIScreen.cz_screenWidth() - 2*LJStatusPictureOutterMargin
/// 图片Item默认宽度
let LJStatusPictureItemWidth = (LJStatusPictureWidth - 2 * LJStatusPictureInnerMargin)/3


// 判断是否是iPhone X
let iPhoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) : false

// 状态栏高度

let STATUS_BAR_HEIGHT = (iPhoneX ? CGFloat(44) : CGFloat(20))
// 导航栏高度
let NavBarHeight = (iPhoneX ? CGFloat(88) : CGFloat(64))
// tabBar高度
let TabBarHeight = (iPhoneX ? CGFloat(49+34) : CGFloat(49))
// home indicator
let HOME_INDICATOR_HEIGHT = (iPhoneX ? CGFloat(34) : CGFloat(0))

