//
//  LJOAuthViewController.swift
//  testPro
//
//  Created by ljkj on 2018/7/10.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import SVProgressHUD


class LJOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        // 取消滚动
        webView.scrollView.isScrollEnabled = false
        webView.delegate = self
        view.backgroundColor = UIColor.white
        title = "登录app"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",  target: self, action: #selector(close), isBackButton: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
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
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
   @objc func autoFill()  { 
    
        // 准备js
     let js = "document.getElementById('userId').value='15993106537';" + "document.getElementById('passwd').value='sun62585542';"
        webView.stringByEvaluatingJavaScript(from:js)
    }
}


// MARK: - UIWebViewDelegate
extension LJOAuthViewController:UIWebViewDelegate {
    
    
    /// webView 将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: request
    ///   - navigationType: 导航类型
    /// - Returns: 是否需要加载请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("加载请求\(request.url?.absoluteString)")
        
        // 如果地址里面包含http://baidu.com 不加载页面 否则加载页面
        if request.url?.absoluteString.hasPrefix(ljAppDirectUrl) == false {
            
            return true
        }
        // 从 http://baidu.com 回调地址的 查询字符串 中 查找code
        // 如果有 授权成功  否则 失败
//        if request.url?.absoluteString.hasPrefix("code=") == false {
//            // 取消授权
//            close()
//            return false
//        }
        // 回调地址的 "查询字符串"中查找code query 就是 ？后面的值
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        LJNetworkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.show(withStatus: "网络请求失败")
            }else {
//                SVProgressHUD.show(withStatus: "登录成功")
              NotificationCenter.default.post(name: NSNotification.Name(LJUserloginSuccessNotification), object: self, userInfo: nil)
                self.close()
            }
        }
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        SVProgressHUD.dismiss()
        
    }
    
}

