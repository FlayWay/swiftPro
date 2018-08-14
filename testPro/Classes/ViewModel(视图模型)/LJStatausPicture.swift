//
//  LJStatausPicture.swift
//  testPro
//
//  Created by ljkj on 2018/7/18.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

@objcMembers class LJStatausPicture: NSObject {

    
    /// 缩率图地址
    var thumbnail_pic:String? {
        
        didSet {
            
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    
    override var description: String {
        
        return yy_modelDescription()
    }
    
    
}
