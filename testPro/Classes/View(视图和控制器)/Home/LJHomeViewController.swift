//
//  LJHomeViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJHomeViewController: LJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @objc private func showFriends() {
        print("显示好友")
    }

}

// MARK: -设置界面
extension LJHomeViewController {
    private func setupUI() {
    
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
    
}
