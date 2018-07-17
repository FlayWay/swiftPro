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
    // 微博信息内容
    var text:String?
    // 用户信息
    var user:LJUser?
    // 计算型属性
    override var description: String{
        
        return yy_modelDescription()
    }
    
}
