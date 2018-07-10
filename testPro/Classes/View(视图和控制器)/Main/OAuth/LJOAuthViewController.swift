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
    
    override func loadView() {
        
        view = webView
        view.backgroundColor = UIColor.white
        title = "登录app"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",  target: self, action: #selector(close), isBackButton: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(LJAppKey)&redirect_uri=\(ljAppDirectUrl)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }

}

// MARK: - 监听方法
extension LJOAuthViewController {
    
   @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
}

