//
//  LJComposeTypeButton.swift
//  testPro
//
//  Created by ljkj on 2018/7/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJComposeTypeButton: UIControl {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    class  func composeTypeButton(imageName:String,title:String) -> LJComposeTypeButton {
        
        let nib = UINib(nibName: "LJComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nib, options: nil)[0] as! LJComposeTypeButton
        btn.titleLable.text = title
        btn.imageView.image = UIImage(named: imageName)
        return btn        
    }

}
