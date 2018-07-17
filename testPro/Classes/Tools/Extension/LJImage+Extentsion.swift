
//
//  LJImage+Extentsion.swift
//  testPro
//
//  Created by ljkj on 2018/7/16.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

extension UIImage {
    
    func avatarImage(size:CGSize?,black:UIColor = UIColor.white,lineColor:UIColor = UIColor.lightGray) -> UIImage? {
        
        var size = size
        if size == nil {
            
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        // 开启图像上下文，内存中开辟一块空间，跟屏幕无关
        /**
           1. size 绘制的尺寸
           2. opaque  false 不透明  true 透明  png 支持透明  jpg不透明
           3. scale 缩放比例
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 填充背景色
        black.setFill()
        UIRectFill(rect)
        // 画圆型图片
        let path = UIBezierPath(ovalIn: rect)
        lineColor.setStroke()
        path.stroke()
        
        // 切圆角
        path.addClip()
        // 画图片
        draw(in: rect)
        
        // 获取图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return result
        
        
    }
    
    
}
