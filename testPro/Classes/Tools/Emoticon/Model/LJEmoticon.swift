//
//  LJEmoticon.swift
//  ceshi1
//
//  Created by ljkj on 2018/7/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import YYModel

@objcMembers class LJEmoticon: NSObject {
    
    /// 表情类型 false 图片表情 / true emoji
    var type:Bool = false
    /// 表情字符串,发送给服务器(节省流量)
    var chs:String?
    /// 表情图片名称，用于本地图文混排
    var png:String?
    /// emoji 十六进制编码
    var code:String?
    /// 表情所在目录
    var directory:String?
    /// 名字对应的图片
    var image:UIImage?{
        
        // 判断图片类型
        if type {
            return nil
        }
        
        guard let directory = directory,
            let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let png = png,
            let bundle = Bundle(path: path)
        else {
            return nil
        }
        
        let image = UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
         return image
    }
    
    
    /// 当前的图像转换成生成图片的图片的属性文本
    ///
    /// - Returns:图片的属性文本
    func imageText(font:UIFont) -> NSAttributedString {
        
        // 判断图片是否存在
        guard let image = image else {
            return NSAttributedString(string: "" )
        }
        // 创建图片附件
        let attachment = NSTextAttachment()
        attachment.image = image
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        // 返回图片文本属性
        return   NSAttributedString(attachment: attachment)
    }
    
    
    override var description: String {
        
        return yy_modelDescription()
        
    }
}
