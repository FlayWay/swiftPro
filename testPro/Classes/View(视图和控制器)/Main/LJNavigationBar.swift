//
//  LJNavigationBar.swift
//  testPro
//
//  Created by ljkj on 2018/6/28.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        
        super.layoutSubviews()
        frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        for subview  in subviews {
            
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            print("--------- \(stringFromClass)")
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 44)
            }
        }
    }
}
