//
//  LJEmoticonManager.swift
//  ceshi1
//
//  Created by ljkj on 2018/7/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation
import YYModel


/// 表情管理器
class  LJEmoticonManager {
    
    // 使用单例，只加载一次表情数据
    static let shared = LJEmoticonManager()
    /// 表情包懒加载数组
    lazy var packages = [LJEmoticonPackage]()
    /// 构造函数，如果在 init 之前加 private 修饰符,可以要求要求访问这必须通过 shared 访问对象
    /// oc 要重写 allocWithZone方法
    private init() {
        loadPackages()
    }
}

private extension LJEmoticonManager {
    
    // 读取 emoticon.plist
    func loadPackages() {
        
        guard  let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
              let bundle = Bundle(path: path),
              let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
              let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
              let models = NSArray.yy_modelArray(with: LJEmoticonPackage.self, json: array) as? [LJEmoticonPackage]  else {
                
            return
        }
        // 获取bundle
        print(bundle)
        // 只要按照bundle 默认的目录结构设定,就可以直接读取 Resources 目录下的文件
//        let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil)
        // 设置表情包数据 不再分配内存 +=
        packages += models
        print(models)
    }
    
}


// MARK: - 表情符号处理  文字找图像
extension LJEmoticonManager {
    
    
    /// 根据字符串找在所有的表情符号中查找对应的表情对象
    ///
    /// - Parameter string: 字符串
    /// - Returns: 如果找到，返回对应的表情模型对象，否则返回nil
    func findEmoticon(string:String) -> LJEmoticon? {
        
        // 遍历表情包
        // oc 中过滤数组用 谓词
        // swift 更简单
        for m in packages {
            
            //方法一 在表情数组中过滤 string
//         let result = m.emoticons.filter { (em) -> Bool in
//
//                return em.chs == string
//            }
            
            /// 方法二  尾随闭包
//            let result = m.emoticons.filter() { (em) -> Bool in
//
//                return em.chs == string
//            }
            
            ///方法三 如果闭包中只有一句，并且是返回  只有一句 指的是  闭包中 只有一行代码 return em.chs == string  并且是返回
            /// 1. 闭包格式可以省略 2. 参数省略之后，使用$0,$1..依次替代原有参数
            let result = m.emoticons.filter() {
                return $0.chs == string
            }
            
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
        
    }
    
    
    /// 将给定的字符串转为属性字符串
    ///
    /// - Parameter string: string
    /// - Returns: NSAttributedString
    func emoticonString(string:String,font:UIFont) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: string)
        // 建立正则表达式 过滤所有的表情文字
        // []  () 都是正则表达式关键字 如果需要参与匹配，需要转义 需要加两个\\
        let pattern = "\\[.*?\\]"
        guard let reg = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        // 匹配所有项
        let matches = reg.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        // 遍历所有项
        for m in matches.reversed() {
            let r = m.range(at: 0)
            let subStr = (string as NSString).substring(with: r)
            print(subStr)
            if let em = LJEmoticonManager.shared.findEmoticon(string: subStr) {
                
                // 使用符号中的属性文本，替换原有的属性文本
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
        }
        
        // 统一设置一遍字符串的属性
        attrString.addAttributes([.font:font], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
}



