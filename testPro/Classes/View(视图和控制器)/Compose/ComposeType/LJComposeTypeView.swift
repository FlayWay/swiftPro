//
//  LJComposeTypeView.swift
//  testPro
//
//  Created by ljkj on 2018/7/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit


/// 撰写微博类型视图
class LJComposeTypeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.cz_random()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 显示当前视图
    func show() {
        
        // 将当前视图添加到 根视图的view上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        vc.view.addSubview(self)
        
        
    }
    
}
