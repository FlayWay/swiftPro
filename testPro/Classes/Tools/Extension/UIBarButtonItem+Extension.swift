//
//  UIBarButtonItem+Extension.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize
    ///   - target: target
    ///   - action: action
    convenience init(title:String,fontSize:CGFloat = 16,target:Any,action: Selector ) {
        let btn:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
