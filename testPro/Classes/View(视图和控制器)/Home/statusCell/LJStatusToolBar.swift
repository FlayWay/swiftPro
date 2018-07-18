//
//  LJStatusToolBar.swift
//  testPro
//
//  Created by ljkj on 2018/7/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJStatusToolBar: UIView {
    
    // 转发
    @IBOutlet weak var reweetButton: UIButton!
    // 评论
    @IBOutlet weak var commentButton: UIButton!
    // 点赞
    @IBOutlet weak var likeButton: UIButton!
    
    
    var viewModel:LJStatusSingleViewModel? {
        
        didSet {
            reweetButton.setTitle(viewModel?.reweetStr, for: UIControlState.normal)
            commentButton.setTitle(viewModel?.commentStr, for: [])
            likeButton.setTitle(viewModel?.likeStr, for: [])
            
        }
    }
    
}
