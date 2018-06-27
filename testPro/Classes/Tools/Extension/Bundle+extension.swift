//
//  Bundle+extension.swift
//  testP
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//
import Foundation

extension Bundle {
    
    //     func namespace() -> String {
    //
    ////        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    //        return infoDictionary?["CFBundleName"] as? String ?? ""
    //    }
    
    // 计算属性
    var namespace:String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
