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
/// 当前日历对象
private let calendar = Calendar.current

extension Date {
    
    static func lj_dataString(time: TimeInterval) -> String {
        
        let date = Date(timeIntervalSinceNow: time)
        //
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    /// 将新浪格式的字符串转日期
    static func lj_sinaDate(string:String) -> Date? {
        
        // 设置日期格式
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        // 转换并返回日期
        return dateFormatter.date(from: string)
    }
    
    var lj_dateDescription: String {
        // 判断是否是今天
        if calendar.isDateInToday(self) {
            
            let delta = self.timeIntervalSinceNow
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                
                return "\(delta/60)分钟前"
            }
            return "\(delta/3600)小时前"
        }
        // 其他天
        var fmt = " HH:mm"
        if  calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        }else {
            fmt = "MM-dd" + fmt
            let year = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            
            if year != thisYear {
                
                fmt = "yyyy-" + fmt
            }
        }
        dateFormatter.dateFormat = fmt
        return dateFormatter.string(from: self)
    }
}
