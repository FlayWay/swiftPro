//
//  LJOAuthViewController.swift
//  testPro
//
//  Created by ljkj on 2018/7/10.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       view = webView
        view.backgroundColor = UIColor.white
        title = "登录app"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",  target: self, action: #selector(close), isBackButton: true)
        
        
    }

}


// MARK: - 监听方法
extension LJOAuthViewController {
    
   @objc func close() {
    
        dismiss(animated: true, completion: nil)
    }
    
}

