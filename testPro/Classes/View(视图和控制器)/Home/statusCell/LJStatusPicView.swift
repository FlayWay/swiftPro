
//
//  LJStatusPicView.swift
//  testPro
//
//  Created by ljkj on 2018/7/18.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJStatusPicView: UIView {

    var viewModel:LJStatusSingleViewModel? {
        
        didSet {
            
            calcViewSize()
        }
    }
    
   /// 根据视图模型的配图视图大小，调整显示内容
   private func calcViewSize() {
    
        // 处理单图 修改单图大小
    if viewModel?.picUrls?.count == 1 {
        
        let viewSize = viewModel?.picktureViewSize ?? CGSize()
        // 获取第0个视图
        let v = subviews[0]
        v.frame = CGRect(x: 0,
                         y: LJStatusPictureOutterMargin,
                         width: viewSize.width,
                         height: viewSize.height - LJStatusPictureOutterMargin)
    }else { // 多图  无图 恢复单图大小  保证九宫格完整
        
        // 之前单个图片高度增加过 需要减去增加的
        let v = subviews[0]
        v.frame = CGRect(x: 0,
                         y: LJStatusPictureOutterMargin,
                         width: LJStatusPictureItemWidth,
                         height: LJStatusPictureItemWidth)

    }
    

        heigthCons.constant = viewModel?.picktureViewSize.height ?? 0
    }
    
    
    /// 图片urls数组
    var urls:[LJStatausPicture]? {
        didSet {
            
            // 1.隐藏所有的imageView
            for v in self.subviews {
                v.isHidden = true
            }
            // 遍历数组，顺序显示图像
            var index = 0
            for url in urls ?? [] {
                
                // 获取索引对应的imageView
                let iv = subviews[index] as! UIImageView
                
                if index == 1 && urls?.count == 4 {
                    
                    index += 1
                }
                
                // 设置图像
                iv.lj_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                // 显示图像
                iv.isHidden = false
                index += 1
            }
            
            
            
            
        }
    }
    /// 配图视图高度
    @IBOutlet weak var heigthCons:NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        setupUI()
    }
    
}


// MARK: - 设置页面
extension LJStatusPicView {
    
    // 1. cell中的所有控件都提前准备好
    // 2. 设置的时候根据数据 控制显示 隐藏
    // 3. 不要动态创建控件
    
    private func setupUI() {
     
        backgroundColor = superview?.backgroundColor
        // 超出部分不显示
        clipsToBounds = true
        
        let count = 3
        let rect = CGRect(x: 0,
                          y: LJStatusPictureOutterMargin,
                          width: LJStatusPictureItemWidth,
                          height: LJStatusPictureItemWidth)
        
        for i in 0..<count * count {
        
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            // 行
            let row = CGFloat(i / 3)
            // 列
            let col = CGFloat(i % 3)
            iv.frame = rect.offsetBy(dx: col * (LJStatusPictureItemWidth + LJStatusPictureInnerMargin), dy: row * (LJStatusPictureItemWidth+LJStatusPictureInnerMargin))
            addSubview(iv)
        }
        
    }
}

