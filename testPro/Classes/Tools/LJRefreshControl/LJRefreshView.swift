//
//  LJRefreshView.swift
//  shuaxin
//
//  Created by ljkj on 2018/7/23.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

// 刷新视图  负责刷新相关的 UI 界面
/**
    ios 动画默认顺时针动画
    就近原则
    要想实现同方向旋转，需要调整非常小的数字(就近原则)
 */
class LJRefreshView: UIView {
    
    
    /// 父视图高度
    var parentViewHeight:CGFloat = 0
    /// 提示图标
    @IBOutlet weak var tipIcon: UIImageView?
    /// 提示标签
    @IBOutlet weak var tipLabel: UILabel?
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    /// 刷新状态
    var refreshState:LJRefreshState = LJRefreshState.normal {
        
        didSet {
            
            switch refreshState {
            case .normal:
                // 恢复状态
                tipIcon?.isHidden = false
                indicator?.stopAnimating()
                tipLabel?.text = "继续使劲拉"
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon?.transform =  CGAffineTransform.identity
                }
            case .pulling:
                tipLabel?.text = "放手就刷新"
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.01))
                }
            case .willRefresh:
                tipLabel?.text = "正在刷新中"
                
                tipIcon?.isHidden = true
                // 显示菊花
                indicator?.startAnimating()
            }
        }
    }
    
    class func refreshView() -> LJRefreshView {
//        LJHumanRefreshView
//        LJRefreshView
//        LJMeiRefreshView
        let nib = UINib(nibName: "LJRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! LJRefreshView
    }

    
}
