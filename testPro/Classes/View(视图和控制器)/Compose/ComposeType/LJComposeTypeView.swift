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

    class func composeTypeView() -> LJComposeTypeView {
    
    
        let nib = UINib(nibName: "LJComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil)[0] as! LJComposeTypeView
        // xib加载默认 600*600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    
    /// 显示当前视图
    func show() {
        // 将当前视图添加到 根视图的view上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
    }
    
    override func awakeFromNib() {
        
        setupUI()
        
    }
    
    @objc private func clickButton() {
        
        print("点击啦")
    }
    
}


private extension LJComposeTypeView {
    
    func setupUI() {
        
        // 创建按钮
        
        let btn = LJComposeTypeButton.composeTypeButton(imageName: "tabbar_compose_camera", title: "测试")
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        addSubview(btn)
    }
}
