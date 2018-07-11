//
//  LJUserAccount.swift
//  testPro
//
//  Created by ljkj on 2018/7/11.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

@objcMembers class LJUserAccount: NSObject {

    /// 访问令牌
    var access_token:String?
    /// 生命周期 开发着五年  使用者 3天
    var expires_in:TimeInterval = 0 {
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户代号
    var uid:String?
    /// 过期时间
    var expiresDate: Date?
    
    override var description: String {
        
        return yy_modelDescription()
    }
}
