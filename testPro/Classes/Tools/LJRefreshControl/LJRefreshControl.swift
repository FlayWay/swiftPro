//
//  LJRefreshControl.swift
//  testPro
//
//  Created by ljkj on 2018/7/22.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

// 刷新状态的临界点
// 普通
private let LJRefreshOffset:CGFloat = 60
// 美团
//private let LJRefreshOffset:CGFloat = 126


/// 刷新状态
///
/// - normal:  普通状态，什么都不做
/// - pulling: 超过临界点,放手刷新
/// - willRefresh: 用户超过临界点，并且放手
enum LJRefreshState {
    case normal
    case pulling
    case willRefresh
}

/// 刷新控件  刷新的逻辑处理
class LJRefreshControl: UIControl {

    
    // 滚动视图的父视图  uitableview、 uicollection
    private weak var scrollView:UIScrollView?
    
    // 刷新视图
    private lazy var refreshView: LJRefreshView = LJRefreshView.refreshView()
    
    init() {
        
        super.init(frame: CGRect())
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }
    /**
        当添加到父视图，newSuperview是父视图
        当视图释放时，newSuperview = nil
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print(newSuperview)
        // 记录父视图
        guard let sv = newSuperview as? UIScrollView else {
            
            return
        }
        
        scrollView = sv
        
        // kvo监听父视图 contentoffset
        scrollView?.addObserver(self
            , forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    //  本试图从父视图上移除
    // 所有的下拉刷新都是监听 父视图的 contentoffset
    // 所有框架的 kvo 监听实现思路都是这个
    override func removeFromSuperview() {
        
        // superView存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
        // superView不存在
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(scrollView?.contentOffset)
        guard let sv = scrollView else {
            
            return
        }
        
        // 初始高度0
        let height = -(sv.contentOffset.y + sv.contentInset.top)
        
        print("高度变化\(height)")
        if  height < 0  {
            
            return
        }
        
        // 传递父视图高度
        if refreshView.refreshState != .willRefresh {

            refreshView.parentViewHeight = height
        }

        // 判断临界点 - 只需要判断一次
        if sv.isDragging {
            
            if height > LJRefreshOffset && (refreshView.refreshState == .normal) {
                print("放手刷新")
                refreshView.refreshState = .pulling
            }else if(height <= LJRefreshOffset && refreshView.refreshState  == .pulling) {
                print("在使劲")
                refreshView.refreshState = .normal
            }
            
        }else {
            // 放手 -- 判断是否超过临界点
            if refreshView.refreshState == .pulling {
                print("准备开始刷新")
              
                beginRefreshing()
                
                // 发送刷新数据事件
                sendActions(for: .valueChanged)
            }
        }
        
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        
    }
    
    /// 开始刷新
    func beginRefreshing() {
        
        print("开始刷新")
        // 判断父视图
        guard let sv = scrollView else {
            return
        }
        
        // 判断是否正在刷新 如果正在刷新 返回
        if refreshView.refreshState == .willRefresh {
            
            return
        }
        
        refreshView.refreshState = .willRefresh
        
        // 调整表格间距
        var inset = sv.contentInset
        inset.top += LJRefreshOffset
        sv.contentInset = inset
        // 设置刷新视图的父视图高度
        refreshView.parentViewHeight = LJRefreshOffset
    }
    
    /// 结束刷新
    func endRefreshing()  {
        
        print("结束刷新")
        // 判断父视图
        guard let sv = scrollView else {
            return
        }
        // 判断是否正在刷新 如果正在刷新 返回
        if refreshView.refreshState != .willRefresh {
            
            return
        }
        
        // 恢复刷新状态
        refreshView.refreshState = .normal
        
        // 恢复表格视图
        var inset = sv.contentInset
        inset.top -= LJRefreshOffset
        sv.contentInset = inset
        
    }
    

}

extension LJRefreshControl {
    
   private  func setupUI() {
    
        backgroundColor = superview?.backgroundColor
        // 超出边界部分不显示
//        clipsToBounds = true
    
        // 添加刷新视图
        addSubview(refreshView)
        // 自动布局  如果自己开发框架，不要用任何的第三方自动布局框架
        refreshView.translatesAutoresizingMaskIntoConstraints = false
         addConstraint(NSLayoutConstraint(item: refreshView,
                                          attribute: .centerX,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .centerX,
                                          multiplier: 1.0,
                                          constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0, constant: refreshView.bounds.width))
     addConstraint(NSLayoutConstraint(item: refreshView,
                                     attribute: .height,
                                     relatedBy: .equal,
                                     toItem: nil,
                                     attribute: .notAnAttribute,
                                     multiplier: 1.0, constant: refreshView.bounds.height))
    
    
    }
}
