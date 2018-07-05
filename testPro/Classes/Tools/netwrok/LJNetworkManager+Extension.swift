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
    
    func statusList(completion:@escaping (_ list:[[String:Any]]?,_ isSuccess:Bool)->()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00hUXEeC31bUKE02e9483882bnmvXE"]
        tokenRequest(urlString: urlString, parameters: nil) { (json, isSuccess) in
            
            // 从json中取出 accessToken
            // 如果 as? 失败  restul为nil
            let result = (json as? NSDictionary)?["statuses"] as? [[String:Any]]
            completion(result,isSuccess)
            
        }
    }
    
    
}
