//
//  LJBaseViewController.swift
//  testPro
//
//  Created by ljkj on 2018/6/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: -界面设置
extension LJBaseViewController {
    
    private func setupUI(){
        view.backgroundColor = UIColor.cz_random()
    }
    
}


