//
//  LJUserAccount.swift
//  testPro
//
//  Created by ljkj on 2018/7/11.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

private let accountFile:NSString = "userAccount.json"

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
    /// 用户昵称
    var screen_name:String?
    /// 用户头像 大图
    var avatar_large:String?
    
    override var description: String {
        
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        
        // 从磁盘加载保存的文件 -> 字典
       guard let path = accountFile.cz_appendDocumentDir(),
            let data = NSData(contentsOfFile: path),
        let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:Any] else {
            
                return
        }
        // 使用字典设置属性 用户是否登录的关键
        yy_modelSet(with: dict ?? [:])
        // 账户过期日期
        expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
        if expiresDate?.compare(Date()) != .orderedDescending {

            print("账户过期")
            access_token = nil
            uid = nil
            try?FileManager.default.removeItem(atPath: path)
        }
        print("正常")
        
    }
    
    /// 存储用户account
    func saveAccount() {
        // 模型转字典
        var dic = self.yy_modelToJSONObject() as? [String: Any] ?? [:]
        // 删除不需要的字典
        dic.removeValue(forKey: "expires_in")
        // 字典序列化 data
        guard let data = try? JSONSerialization.data(withJSONObject: dic, options: [.prettyPrinted]),
              let filePath = accountFile.cz_appendDocumentDir() else {
            return
        }
        
        (data as NSData).write(toFile: filePath, atomically: true)
        print("用户token地址\(filePath)")
        
        
    }

}
