//
//  LJStatusModel.swift
//  testPro
//
//  Created by ljkj on 2018/7/5.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import YYModel

@objcMembers class LJStatusModel: NSObject {
    
    // 基本数据类型 赋0
    // int 类型 在64位机器中是64位 在32位中是32位
    // 如果不写Int64 在5c/4s/ipad2 上无法运行
    var id:Int64 = 0
    /// 微博信息内容
    var text:String?
    /// 用户信息
    var user:LJUser?
    /// 转发数
    var reposts_count:Int = 0
    /// 评论数
    var comments_count:Int = 0
    /// 表态数
    var attitudes_count:Int = 0
    /// 配图视图模型
    var pic_urls:[LJStatausPicture]?
    /// 转发微博
    var retweeted_status:LJStatusModel?
    
    /// 计算型属性
    override var description: String{
        
        return yy_modelDescription()
    }
    
    ///类函数 告诉第三方框架 YY_model 如果遇到数组类型的属性，数组中存放的对象是什么类
    class func modelContainerPropertyGenericClass() -> [String:AnyClass] {
        return ["pic_urls":LJStatausPicture.self]
    }
    
}
