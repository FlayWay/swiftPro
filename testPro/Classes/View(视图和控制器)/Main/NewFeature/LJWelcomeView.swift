//
//  LJWelcomeView.swift
//  testPro
//
//  Created by ljkj on 2018/7/12.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import  SDWebImage

/// 欢迎视图
class LJWelcomeView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLable: UILabel!
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView() -> LJWelcomeView{
        
        let nib = UINib(nibName: "LJWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! LJWelcomeView
        // 从xib加载的视图 默认是600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    
//    override init(frame: CGRect) {
//
//        super.init(frame: frame)
//        backgroundColor = UIColor.red
//
//    }
//
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 还没有和代码连线建立关系
        print("initWithCode+\(iconView)")
    }
    
    override func awakeFromNib() {
        
        print("initWithCode+\(iconView)")
        // url
        guard let urlString = LJNetworkManager.shared.userAccount.avatar_large,
              let url = URL(string: urlString)  else {
            return
        }
        
        // 设置头像 PNG 支持透明/ JPG 不支持透明
        let image = UIImage(named: "avatar_default")
        iconView.image = avatarImage(image: image!, size: image!.size, black: self.backgroundColor)
//        iconView.sd_setImage(with: url, placeholderImage: image)
//        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
//        iconView.layer.masksToBounds = true
        
    }
    
    func avatarImage(image:UIImage,size:CGSize,black:UIColor?) -> UIImage? {
        
        let rect = CGRect(origin: CGPoint(), size: size)
        
        /**
            图像的上下文 - 内存中开辟一块空间，跟屏幕无关
         参数
            size: 绘图的尺寸
            opaque: 透明度 false 透明 /true 不透明
            scale: 缩放比例  一般默认0
        */
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        // 背景颜色填充
        black?.setFill()
        UIRectFill(rect)
        // 实例化圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 对圆形剪切
        path.addClip()
        // 绘制边线
        UIColor.darkGray.setStroke()
        path.stroke()
        path.lineWidth = 2
        // 绘制图像
        image.draw(in: rect)
        
        // 获取图像
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return result
    }
    
    
    
    /// 自动布局后系统更新完成约束后，会自动调用此方法
    /// 通常是对子视图进行修改
//    override func layoutSubviews() {
//
//
//    }
    // 视图添加到window 表示视图已经显示
    override func didMoveToWindow() {
      super.didMoveToWindow()
        self.layoutIfNeeded()
        self.bottomCons.constant = self.bounds.size.height - 260
        UIView.animateKeyframes(withDuration: 3.0,
                                delay: 0,
                                options: [],
                                animations: {
                        self.layoutIfNeeded()
        }) { (_) in
         
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLable.alpha = 1

            }, completion: { (_) in
                
                self.removeFromSuperview()
            })
        }
    }
    
}




