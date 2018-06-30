//
//  LJVisitorView.swift
//  testPro
//
//  Created by ljkj on 2018/6/30.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit


/// 访客视图
class LJVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -设置界面
extension LJVisitorView {
    
    private func setupUI() {
    
        backgroundColor = UIColor.white
        
    }
}
