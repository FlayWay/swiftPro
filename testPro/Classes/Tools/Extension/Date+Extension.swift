//
//  Date+Extension.swift
//  testPro
//
//  Created by ljkj on 2018/8/13.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation

/// 日期格式化器，不要频繁的创建和释放，会影响性能
private let dateFormatter = DateFormatter()

extension Date {
    
    static func lj_dataString(time: TimeInterval) -> String {
        
        let date = Date(timeIntervalSinceNow: time)
        //
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
        
    }
}
