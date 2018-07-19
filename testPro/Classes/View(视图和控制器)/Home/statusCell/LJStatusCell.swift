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
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            // 用户头像
            iconView.lj_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default"), isAvatar: true)
            // 底部工具栏
            toolBar.viewModel = viewModel
            
            // 配图视图模型
            picktrueView.viewModel = viewModel
            
            // 测试修改配置视图高度
//            picktrueView.heigthCons.constant = viewModel?.picktureViewSize.height ?? 0
            // 图片数组
//            if (viewModel?.status.pic_urls?.count)! > 4 {
//
//                var picUlrs = viewModel!.status.pic_urls!
//                picUlrs.removeSubrange((picUlrs.startIndex+4)..<picUlrs.endIndex)
//
//                picktrueView.urls = picUlrs
//
//            }else {
            // 设置配图(包含原创和被转发)
            picktrueView.urls = viewModel?.picUrls
//            }
//            pictureTopsCon.constant = 0
            
            reweetLable?.text = viewModel?.reweetText
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var memberIconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var vipIconView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    /// 底部工具栏
    @IBOutlet weak var toolBar: LJStatusToolBar!
    /// 配图视图
    @IBOutlet weak var picktrueView: LJStatusPicView!

    /// 被转发正文 原创微博中没有此控件， 用 ？
    @IBOutlet weak var reweetLable: UILabel?
    
    @IBOutlet weak var pictureTopsCon: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
