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
    /// 认证图标
    var vipIcon:UIImage?
    /// 转发
    var reweetStr: String?
    /// 评论
    var commentStr: String?
    /// 点赞
    var likeStr: String?
    /// 配图视图大小
    var picktureViewSize = CGSize()
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
        // 认证图标
        switch model.user?.verified_type {
        case 0:
            vipIcon = UIImage(named: "avatar_vip_golden")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        // 设置底部字符串
        reweetStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        // 计算配图视图大小
        picktureViewSize = calPictureViewSize(count: model.pic_urls?.count)
        
        
    }
    
    var description: String {

        return status.description
    }
    
    /// 计算指定图片的配图视图大小
    ///
    /// - Parameter count: 图片数量
    /// - Returns: 视图大小
    func calPictureViewSize(count:Int?) -> CGSize  {
        
        // 计算配图视图宽度
        // 常数设置
        let LJStatusPictureOutterMargin = CGFloat(12)
        // 内部图像间距
        let LJStatusPictureInnerMargin = CGFloat(3)
        // 宽度
        let LJStatusPictureWidth = UIScreen.cz_screenWidth() - 2*LJStatusPictureOutterMargin
        // 高度
        // 每个默认item宽度
        let LJStatusPictureItemWidth = (LJStatusPictureWidth - 2*LJStatusPictureInnerMargin) / 3
        
        if count == 0 || count == nil {
            
            return CGSize()
        }
        
        // 根据count 知道行数
        let row = (count! - 1)/3 + 1
        
        let height = LJStatusPictureOutterMargin +  CGFloat(row) * LJStatusPictureItemWidth + CGFloat(row-1) * LJStatusPictureInnerMargin
        
        return CGSize(width:LJStatusPictureWidth , height: height)
    }
    
    
   private func countString(count:Int,defaultStr:String) -> String {
        
        if count == 0 {
            
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f万", Double(count) / 10000)
        
    }
    
}
