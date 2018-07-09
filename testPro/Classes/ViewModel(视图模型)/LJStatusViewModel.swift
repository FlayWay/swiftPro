//
//  LJStatusViewModel.swift
//  testPro
//
//  Created by ljkj on 2018/7/5.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

// 如果类需要使用 kvc 或者 字典转模型框架设置对象值，类就需要继承 NSObject
// 如果类只是包装一些逻辑代码，可以不需要父类，好处：更加轻量级
// 如果是oc 一律继承NSObject

/// 上拉刷新最大尝试次数
private var maxPullUpTimes = 3

class LJStatusViewModel: NSObject {

    lazy var statusList = [LJStatusModel]()
    /// 上拉刷新错误次数
    private var pullUpErrorTimes = 0
    // 加载微博列表
    ///
    /// - Parameters:
    ///   - pullup: 上拉刷新标记
    ///   - completion: 完成回调
    func loadData(pullup:Bool,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->())  {
        
        // 判断是否是上拉刷新,同时检查刷新错误
        if pullup && (self.pullUpErrorTimes > maxPullUpTimes){
            completion(true,false)
            return
        }
        
        // since_id： 下拉刷新
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        // max_id 上拉刷新
        let max_id = !pullup ? 0 : (statusList.last?.id ?? 0)
        
        LJNetworkManager.shared.statusList(since_id: since_id,max_id: max_id) { (list, isSuccess) in
            
            // 1.字典转模型
            guard let array = NSArray.yy_modelArray(with: LJStatusModel.self, json:list!) as? [LJStatusModel] else{
                completion(isSuccess,false)
                return
            }
            
            print("测试数据\(array.count)")
            // 拼接数据
            // 上拉刷新将结果拼接到数组后面
            if pullup {
                self.statusList += array
            } else {
                // 下拉刷新应该将数组结果拼接到数组前面
                self.statusList = array + self.statusList
            }
            // 判断上拉刷新的数据量
            if pullup && array.count == 0 {
                self.pullUpErrorTimes += 1
                completion(isSuccess,false)
                print("错误次数\(self.pullUpErrorTimes)")
            }else {
                completion(isSuccess,true)
            }
            
            
            // 完成加载
//            completion(isSuccess)
        }
    }
}
