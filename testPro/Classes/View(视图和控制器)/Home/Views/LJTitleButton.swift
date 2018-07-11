//
//  LJTitleButton.swift
//  testPro
//
//  Created by ljkj on 2018/7/11.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJTitleButton: UIButton {

    
    /// 重造构造函数
    ///
    /// - Parameter title: title为nil 显示首页  不为nil 就显示图片和文字
    init(title:String) {
        super.init(frame: CGRect())
        
        if title == "" {
            setTitle("首页", for: .normal)
        }else {
            setTitle(title, for: .normal)
            setImage(UIImage(named: "navigation_down"), for: .normal)
            setImage(UIImage(named: "navigation_up"), for: .selected)
        }
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        // 设置大小
        sizeToFit()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let titleLable = titleLabel,
              let imageView = imageView else {
        
                return
        }
        titleLable.frame.origin.x = 0
        imageView.frame.origin.x = titleLable.bounds.width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
