//
//  LJStatusListDAL.swift
//  testPro
//
//  Created by ljkj on 2018/8/12.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation

/// DAL -- Data Access Layer 数据访问层
/// 作用 负责处理数据网络层和数据库，给listModel返回微博的字典数组
class LJStatusListDAL {
    
    
    /// 从本地数据 或者 网络加载
    ///
    /// - Parameters:
    ///   - since_id: 下拉刷新id
    ///   - max_id: 上拉刷新id
    ///   - completion: 回调
    class func loadStatus(since_id:Int64 = 0,max_id:Int64 = 0, completion:@escaping (_ list:[[String:Any]]?,_ isSuccess:Bool)->()) {
        
        //0. 获取用户id
        guard let userId = LJNetworkManager.shared.userAccount.uid else {
            return
        }
        //1. 检查本地数据是，如果有直接返回
        let array = LJSQLiteManager.shared.loadStatus(userid: userId, since_id: since_id, max_id: max_id)
        // 判断数组的个数，没有数据返回的数组是空
        if array.count > 0 {
            completion(array,true)
            return
        }
        
        //2. 加载网络数据
        LJNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 判断网络是否成功
            if !isSuccess {
                completion(nil,false)
                return
            }
            
            guard let list = list else {
                completion(nil,isSuccess)
                return
            }
            //3. 加载完成之后，将网络数据写入数据库
            LJSQLiteManager.shared.updateStatus(userid: userId, array: list)
            //4. 返回网络数据
            completion(list,isSuccess)
        }
    }
    
}


