//
//  LJEmoticonPackage.swift
//  ceshi1
//
//  Created by ljkj on 2018/7/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

@objcMembers class LJEmoticonPackage: NSObject {

    
    /// 表情包目录
    var groupName:String?
    /// 表情包目录，从目录加载 info.plist 可以创建表情模型数组
    var directory:String? {
        
        didSet {
            // 当设置目录时，从目录下加载info.plist
            guard let directory = directory,
                  let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
                  let bundle = Bundle(path: path),
                  let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
            let array = NSArray(contentsOfFile: infoPath) as? [[String:String]],
            let models = NSArray.yy_modelArray(with: LJEmoticon.self, json: array) as? [LJEmoticon]
                else {
                return
            }
            emoticons += models
            
            for m in models {
                
                m.directory = directory
            }
        }
    }
    /// 懒加载的表情模型数组
    /// 使用懒加载可以避免后续的解包
    lazy var emoticons = [LJEmoticon]()
    /// 目录图片
    var bgImageName:String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
