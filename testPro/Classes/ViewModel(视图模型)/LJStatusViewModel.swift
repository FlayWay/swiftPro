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

class LJStatusViewModel: NSObject {

    lazy var statusList = [LJStatusModel]()
    // 加载微博列表
    // 
    func loadData(completion:@escaping (_ isSuccess:Bool)->())  {
        
        LJNetworkManager.shared.statusList { (list, isSuccess) in
            // 1.字典转模型
            guard let array = NSArray.yy_modelArray(with: LJStatusModel.self, json:list!) as? [LJStatusModel] else{
                completion(isSuccess)
                return
            }
            print("测试数据\(array)")
            // 拼接数据
            self.statusList += array
            // 完成加载
            completion(isSuccess)
        }
        
    }
    
    
}
