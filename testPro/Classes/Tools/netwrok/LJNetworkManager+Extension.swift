//
//  LJNetworkManager+Extension.swift
//  testPro
//
//  Created by ljkj on 2018/7/4.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation

// MARK: -封装wb的网络请求方法
extension LJNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - since_id: 返回比since_id大的微博，默认0
    ///   - max_id: 返回比max_id小的微博 默认 0
    ///   - completion: 完成回调 list
    func statusList(since_id:Int64 = 0,max_id:Int64 = 0, completion:@escaping (_ list:[[String:Any]]?,_ isSuccess:Bool)->()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00hUXEeC31bUKE02e9483882bnmvXE"]
        // swift 中int 可以转为any 但是 Int64不可以
        let params = ["since_id":"\(since_id)",
            "max_id":"\(max_id > 0 ? max_id - 1 : 0)"]
        tokenRequest(urlString: urlString, parameters: params) { (json, isSuccess) in
            
            // 从json中取出 accessToken
            // 如果 as? 失败  restul为nil
            // 服务器返回的数据，按照时间倒序排序的
            let result = (json as? NSDictionary)?["statuses"] as? [[String:Any]]
            completion(result,isSuccess)
        }
    }
    
    
    /// 返回微博的未读数量
    func unreadCount(completion:@escaping(_ count:Int) -> ()) {
        
        guard let uid = uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json";
        let params = ["uid":uid]
        tokenRequest(urlString: urlString, parameters: params) { (json, isSuccess) in
            
            print("取出数据信息\(json ?? "无数据")")
            let dict = json as? [String:Any]
            let count = dict?["status"] as? Int
            completion(count ?? 0)

        }
        
    }
    
    // 获取授权码
    
    
  
    
}
