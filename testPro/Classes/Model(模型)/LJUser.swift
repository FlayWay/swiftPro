//
//  LJUser.swift
//  testPro
//
//  Created by ljkj on 2018/7/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit


/// 用户模型
@objcMembers  class LJUser: NSObject {

    /// 用户UID
    var id:Int64 = 0
    /// 用户昵称
    var screen_name:String?
    /// 用户头像地址
    var profile_image_url:String?
    /// 是否是认证用户，即加V用户，true：是，false：否
    var verified_type:Int = 0
    /// 会员等级
    var mbrank:Int = 0
    // 显示问题
    override var description: String {
        
        return yy_modelDescription()
    }
}
