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
        
        let vc = LJDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: -设置界面
extension LJHomeViewController {
    // 重写父类方法
    private func setupUI() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
    }
    
}
