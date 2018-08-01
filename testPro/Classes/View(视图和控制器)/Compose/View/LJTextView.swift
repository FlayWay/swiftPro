//
//  LJTextView.swift
//  testPro
//
//  Created by ljkj on 2018/8/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJTextView: UITextView {

    lazy var placeholderLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    
    /// 监听输入内容
    @objc private func textChanged() {
        // 如果有文本 显示文本 否则显示
        placeholderLabel.isHidden = self.hasText
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - LJTextView
private extension LJTextView {
    
    func setupUI() {
        // 注册通知 一对多 如果其他控件监听当前文本视图的通知，不会影响
        // 如果使用代理，其他控件就无法使用代理监听通知
        // 代理一对一 
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: Notification.Name.UITextViewTextDidChange, object: self)
        
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
        
        // 测试
//        self.delegate = self
        
    }
    
}

extension LJTextView:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print("哈哈")
    }
    
}
