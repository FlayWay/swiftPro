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
    ///   - isBackButton: isBackButton
    convenience init(title:String,fontSize:CGFloat = 16,target:Any,action: Selector,isBackButton:Bool = false) {
        let btn:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        if isBackButton == true {
            let imageNor = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageNor), for: .normal)
            btn.setImage(UIImage(named: imageNor+"_highlighted"), for:.highlighted)
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
