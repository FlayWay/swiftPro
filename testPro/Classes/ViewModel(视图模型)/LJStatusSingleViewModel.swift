//
//  LJStatusSingleViewModel.swift
//  testPro
//
//  Created by ljkj on 2018/7/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit


/// 单条数据模型

/// 如果没有任何父类，需要打印显示信息
// 1、 遵守 CustomStringConvertible
// 2、 实现 description方法

/**
    关于表格的优化  用牺牲内存换取cpu
    尽量少计算 所有需要的素材提前计算好
    控件上不要设置圆角半径,所有图片渲染的属性都要考虑
    所有cell上的控件都要提前创建好，在显示的时候根据数据显示、隐藏
    cell中控件的层次越少越好，数量越少越好
    要测量，不要猜测 屏幕刷新60帧 
*/

class LJStatusSingleViewModel: CustomStringConvertible {


    /// 数据模型
    var status:LJStatusModel
    /// 会员图标  -- 存储型属性 用内存换取cpu
    var memberIcon:UIImage?
    /// 构造函数
    ///
    /// - Parameter model: 返回视图模型
    init(model:LJStatusModel) {
        
        self.status = model
        
        // common_icon_membership_level
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
    }
    
    var description: String {

        return status.description
    }
    
    
}
