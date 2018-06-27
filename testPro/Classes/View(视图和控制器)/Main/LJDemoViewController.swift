//
//  LJDemoViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJDemoViewController: LJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: -监听方法  push到下一个页面
    @objc private func nextAction(){
    
        let vc = LJDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LJDemoViewController {
    
    private func setupUI(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(nextAction))
        navigationItem.title = "第\(navigationController?.viewControllers.count ?? 0)个"
    }
}
