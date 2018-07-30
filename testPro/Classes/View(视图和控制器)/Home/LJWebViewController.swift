//
//  LJWebViewController.swift
//  testPro
//
//  Created by ljkj on 2018/7/30.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJWebViewController: LJBaseViewController {

  private  lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    var urlString:String? {
        
        didSet {
            
            guard let urlString = urlString ,
                  let url = URL(string: urlString)
            else {
                
                return
            }
            let req = URLRequest(url: url)
            webView.loadRequest(req)
        }
    }
    
}

extension LJWebViewController {
    
    override func setupTableView() {
        
//        super.setupTableView()
        navItem.title = "网页"
        view.insertSubview(webView, belowSubview: navigationBar)
        webView.backgroundColor = UIColor.gray
        
        
    }
}
