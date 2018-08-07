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
    // 返回纯文本
    var emoticonText:String?{
        
        // 获取textView属性文本
        guard let attrStr = self.attributedText else {
            return ""
        }
        // 需要获取属性文本中的图片(将属性图片转为文本)
        /*
         * 遍历的返回
         选项
         闭包
         */
        var result = String()
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: []) { (dict, range, _) in
            
            print(dict)
            print(range)
            if let attachment = dict[NSAttributedStringKey.attachment] as? LJTextAttachment {
                print("图片")
                
                result += attachment.chs ?? ""
                
            } else {
                let subStr = (attrStr.string as NSString).substring(with: range)
                result += subStr
            }
            
        }
        print("=========\(result)")
        return result
    }
    
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
    
    /// 插入表情
    func insertEmoticon(em:LJEmoticon?) {
        
        // em 为nil 删除按钮
        guard let em = em else{
            // 删除文本
            deleteBackward()
            return
        }
        // emoji字符串
        if  let emoji = em.emoji,
            let textRange = selectedTextRange {
            //
            replace(textRange, withText: emoji)
            return
        }
        
        // 都是图片表情
        // 所有的排版系统中，几乎都有一个共同的特点,插入字符的显示，跟随前一个字符的属性，但本身没有属性
        let imageText = em.imageText(font: font!)
        
        // 获取当前textView属性文本
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        // 将当前属性文本插入到光标位置
        attrStrM.replaceCharacters(in: selectedRange, with: imageText)
        // 重新设置属性文本
        // 记录光标位置
        let range = selectedRange
        attributedText = attrStrM
        
        // 恢复光标位置
        selectedRange = NSRange(location: range.location + 1, length: range.length)
        
        // 执行代理方法
        delegate?.textViewDidChange?(self)
        // 文本内容变化方法
        textChanged()
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
        
    }
    
}
