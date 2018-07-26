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
    
    /// 被转发正文
    var reweetText: String?
    
    /// 行高
    var rowHeight: CGFloat = 0
    
    /// 来源字符串
    var sourceStr:String?
    
    /// 如果是被转发微博，原创微博一定没有图
    var picUrls:[LJStatausPicture]? {
        // 如果转发微博有配图，返回转发微博配图， 没有返回原创微博配图 都没有返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
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
        picktureViewSize = calPictureViewSize(count: picUrls?.count)
        // 设置被转发文字
        let reweetTextStr = "@" + (status.retweeted_status?.user?.screen_name ?? "")
        reweetText = reweetTextStr + ":" + (status.retweeted_status?.text ?? "")
        
        // 来源字符串
        sourceStr =  "来自" + (model.source?.lj_href()?.text ?? "")
        // 计算行高
        updateRowHeight()
    
    }
    
    var description: String {

        return status.description
    }
    
    
    /// 使用单个图像，更新视图大小
    ///
    /// - Parameter image: 网络缓存的单个大小
    func updateSingleImageSize(image:UIImage) {
        
        var size = image.size
        
        let maxWidth:CGFloat = 200
        let minWidth:CGFloat = 30
        // 过宽图片处理
        if size.width > maxWidth {
            size.width = maxWidth
            
            size.height = size.width * image.size.height / image.size.width
        }
        // 过窄图片处理
        if  size.width < minWidth {
            size.width = minWidth
            
            size.height = size.width * image.size.height / image.size.width
        }
        
        // 过高处理
        if size.height > 200 {
            
            size.height = 200
        }
    
        // 尺寸需要增加顶部的12个点
        size.height += LJStatusPictureOutterMargin
        picktureViewSize = size
        
        // 重新计算行高
        updateRowHeight()
    }
    
    /// 计算指定图片的配图视图大小
    ///
    /// - Parameter count: 图片数量
    /// - Returns: 视图大小
    func calPictureViewSize(count:Int?) -> CGSize  {
        
        // 计算配图视图宽度
        // 高度
        if count == 0 || count == nil {
            
            return CGSize()
        }
        
        // 根据count 知道行数
        let row = (count! - 1)/3 + 1
        let height = LJStatusPictureOutterMargin +  CGFloat(row) * LJStatusPictureItemWidth + CGFloat(row-1) * LJStatusPictureInnerMargin
        
        return CGSize(width:LJStatusPictureWidth , height: height)
    }
    
    /// 更新当前视图模型计算行高
    func updateRowHeight(){
        // 原创行高: 顶部分割视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12) + 配图视图高度(需要计算) + 间距(12) + 底部视图高度(35)
        // 转发高度: 顶部分割视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12) + 被转发高度(需要计算) + 间距(12) + 配图视图高度(需要计算) + 间距(12) + 底部视图高度(35)
        let margin:CGFloat = 12
        let iconHeight:CGFloat = 34
        let toolBarHeight:CGFloat = 35
        
        var  height:CGFloat = 0
        
        
        let viewSize = CGSize(width: UIScreen.cz_screenWidth() - 2 * margin, height: CGFloat(MAXFLOAT))
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        // 计算顶部位置
        height = 2 * margin + iconHeight + margin
        // 计算正文高度
        if  let text = status.text {
            
             // 换行文本 统一使用 usesLineFragmentOrigin
           height += (text as NSString).boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], attributes:[ .font:originalFont] , context: nil).height
        }
    
        // 判断是否转发微博
        if  status.retweeted_status != nil {
            
            height += margin * 2
            // 转发文本高度
            if let text = reweetText {
                 height += (text as NSString).boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], attributes:[ .font: retweetedFont] , context: nil).height
            }
        }
        
        // 配图视图高度
        height += picktureViewSize.height
        height += margin
        
        // 底部工具栏
        height += toolBarHeight
        rowHeight = height
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
