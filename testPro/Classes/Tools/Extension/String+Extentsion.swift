//
//  String+Extentsion.swift
//  ce1
//
//  Created by ljkj on 2018/7/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation

extension String {
    
    
    /// 从当前字符串中提取 链接和文字
    /// swift提供了元祖,同时返回多个值
    func lj_href() -> (link:String,text:String)? {
        
        let pattern = "<a href=\"(.*?)\".*?\">(.*?)</a>"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
        let result = regx.firstMatch(in:self, options: [], range: NSRange(location: 0, length: characters.count))  else {
            
            return nil
        }

       // 获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        print("\(link)---------\(text)")
        return (link,text)
        
    }
    
}
