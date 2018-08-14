
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
                // 判断是否是 gif
                iv.subviews[0].isHidden = (((url.thumbnail_pic ?? "") as NSString).pathExtension.lowercased() != "gif")
                
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
    
    //MARK: --图片点击事件
    @objc private func tapImageView(tap:UITapGestureRecognizer){
        
        guard let iv = tap.view ,
            let picUrls = viewModel?.picUrls
        else {
            return
        }
        var selectedIndex = iv.tag
        
        if picUrls.count == 4 && selectedIndex > 1 {
            
            selectedIndex -= 1
        }
        
        let urls = (picUrls as NSArray).value(forKey: "largePic") as! [String]
        
        var imageViewList = [UIImageView]()
        for iv in subviews as! [UIImageView] {
            
            if !iv.isHidden {
                
                imageViewList.append(iv)
                
            }
        }
        
        // 发送通知
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: LJStatusCellBrowserPhotoNotification), object: self, userInfo:
            [
            LJStatusCellBrowserPhotoSelectedIndexKey:selectedIndex,
            LJStatusCellBrowserPhotoImageViewsKey:imageViewList,
            LJStatusCellBrowserPhotoUrlsKey:urls
            ])
        
        
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
            
            iv.tag = i
            
            // 设置手势
            iv.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
            iv.addGestureRecognizer(tap)
            
            addGifView(iv: iv)
        }
        
    }
    
    // 向图像加载一个gif图像视图
    private func addGifView(iv:UIImageView) {
       let gifImageView = UIImageView(image:UIImage(named: "timeline_image_gif"))
       iv.addSubview(gifImageView)
        
       gifImageView.translatesAutoresizingMaskIntoConstraints = false
        
       iv.addConstraint(NSLayoutConstraint(
        item: gifImageView,
        attribute: .right,
        relatedBy: .equal,
        toItem: iv,
        attribute: .right,
        multiplier: 1.0,
        constant: 0))
    
    iv.addConstraint(NSLayoutConstraint(
        item: gifImageView,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: iv,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0))
    }
}

