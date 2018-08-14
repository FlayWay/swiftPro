//
//  LJComposeViewController.swift
//  testPro
//
//  Created by ljkj on 2018/7/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import SVProgressHUD


/**
    加载控制器的时候，如果 xib 和 控制器同名,默认的构造函数，会优先加载xib
 */

class LJComposeViewController: UIViewController {

    /// 工具栏底部约束
    @IBOutlet weak var toolBarBottomCon: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    // option + enter 换行
    // 选中内容并设置文本属性
    // 如果想要设置间距，增加一个空行，可以设置空行的字体高度来设置间距
    @IBOutlet var titleLabel: UILabel!
    /// 文本编辑视图
    @IBOutlet weak var textView: LJTextView!
    // 表情输入视图
    lazy var emoticonInputView = LJEmoticonInputView.inputView {[weak self] (em) in
        self?.textView.insertEmoticon(em: em)
        
//        .insertEmoticon(em: em)
    }
    /// 工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        textView.resignFirstResponder()
    }
    
    
    /// 发布按钮事件
    @IBAction func postStatus(_ sender: UIButton) {
        
        print("点击啦")
        // 获取文字
        guard let text = textView.emoticonText else {
            return
        }
        
        let image = UIImage(named: "")
        LJNetworkManager.shared.postStatus(text: text,image: image) { (result, isSuccess) in
            
            SVProgressHUD.setDefaultStyle(.dark)
            let message = isSuccess ? "发布成功" : "网络不给力"
            SVProgressHUD.showInfo(withStatus: message)
            
            if isSuccess {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4, execute: {
                    self.close()
                    SVProgressHUD.setDefaultStyle(.light)
                })
            }
            
        }
        
    }
    
    
   /// 切换表情键盘
   @objc private func emoticonKeyboard() {
    
        print("点击了表情")
        // textView.inputView就是文本框的输入内容
        // 如果使用系统默认的键盘,输入视图为nil
        // 视图宽度可以随便，就是屏幕宽度
//        let keyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 253))
//        keyboardView.backgroundColor = UIColor.blue
    
        // 设置键盘视图
        textView.inputView = (textView.inputView == nil) ? emoticonInputView : nil
        // 刷新键盘视图
        textView.reloadInputViews()
        // 助理视图随着键盘的下落消失
        // textView.inputAccessoryView
    }
    
    /// 监听键盘高度变化
    @objc private  func keyboardChanged(_ notification:Notification) {
        
        print("测试\(notification)")
        // rect
        guard let rect = (notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue else {
            
            return
        }
        
        let offset = view.bounds.height - rect.origin.y
        toolBarBottomCon.constant = offset
        UIView.animate(withDuration: 0.25) {
            
            self.view.layoutIfNeeded()
        }
        
        print(NSStringFromCGRect(toolBar.frame))
        
    }
    
    
//    lazy var sendButton: UIButton = {
//
//        let btn = UIButton()
//        btn.setTitle("发布", for: .normal)
//
//        btn.setTitleColor(UIColor.white, for: .normal)
//        btn.setTitleColor(UIColor.gray, for: .disabled)
//
//        btn.setBackgroundImage(UIImage(named: "common_button_orange"), for: .normal)
//        btn.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
//        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
//
//        btn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
//
//        return btn
//    }()
}

private extension LJComposeViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        setupNavgationBar()
        setupToolbar()
    }
    
    /// 设置导航栏
    func setupNavgationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        sendButton.isEnabled = false
        navigationItem.titleView = titleLabel
    }
    
    /// 设置工具栏
    func setupToolbar() {
        
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        
        var items = [UIBarButtonItem]()
        
        for s in itemSettings {
            
            guard let imageName = s["imageName"] else {
                continue
            }
            
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let btn = UIButton()
            btn.setImage(image, for: .normal)
            btn.setImage(imageHL, for: .highlighted)
            btn.sizeToFit()
            // 判断 actionName
            if let actionName = s["actionName"] {
                 // 给按钮添加监听方法
                btn.addTarget(self, action: #selector(emoticonKeyboard), for: .touchUpInside)
            }
            
            items.append(UIBarButtonItem(customView: btn))
            // 追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
        }
        // 删除末尾弹簧
        items.removeLast()
        toolBar.items = items
    }
}

// MARK: -UITextViewDelegate
extension LJComposeViewController:UITextViewDelegate {
    
    
    /// 发现文字变化
    func textViewDidChange(_ textView: UITextView) {
        
        sendButton.isEnabled = textView.hasText
    }
    
}
