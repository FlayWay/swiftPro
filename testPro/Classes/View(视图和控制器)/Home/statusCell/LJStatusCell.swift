//
//  LJStatusCell.swift
//  testPro
//
//  Created by ljkj on 2018/7/16.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJStatusCell: UITableViewCell {

    
    /// 单条数据模型
    var viewModel:LJStatusSingleViewModel? {
        
        didSet {
            // 微博正文
            statusLabel?.text = viewModel?.status.text
            // 名字
            nameLab.text = viewModel?.status.user?.screen_name
            // 设置会员等级
            memberIconView.image = viewModel?.memberIcon
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var memberIconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var vipIconView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
