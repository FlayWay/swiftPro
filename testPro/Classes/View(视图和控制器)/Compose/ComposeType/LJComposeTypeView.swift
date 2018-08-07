//
//  LJComposeTypeView.swift
//  testPro
//
//  Created by ljkj on 2018/7/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import pop


/// 撰写微博类型视图
class LJComposeTypeView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    /// 关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    @IBOutlet weak var returnButtonCenterXcons: NSLayoutConstraint!
    @IBOutlet weak var returnButton: UIButton!
    
    private var completionBlock:((_ clsName:String?) -> ())?
    
    // 按钮数组
    private let buttonsInfo = [
        ["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "LJComposeViewController"],
        ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
        ["imageName": "tabbar_compose_weibo", "title": "长微博"],
        ["imageName": "tabbar_compose_lbs", "title": "签到"],
        ["imageName": "tabbar_compose_review", "title": "点评"],
        ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
        ["imageName": "tabbar_compose_friend", "title": "好友圈"],
        ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
        ["imageName": "tabbar_compose_music", "title": "音乐"],
        ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]
    
    class func composeTypeView() -> LJComposeTypeView {
    
        let nib = UINib(nibName: "LJComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil)[0] as! LJComposeTypeView
        // xib加载默认 600*600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    
    /// 显示当前视图
    func show(completion:@escaping(_ clsName:String?) ->() ) {
        
        completionBlock = completion
        
        // 将当前视图添加到 根视图的view上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
        // 开始动画
        showCurrentView()
        
    }
    
    override func awakeFromNib() {
        
        setupUI()
        
    }
    
    @objc private func clickButton(selectedButton:LJComposeTypeButton) {
        
        print("点击啦")
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        for (i,btn) in v.subviews.enumerated() {
            
            // 缩放
            let scaleAnmi:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            // x,y 在系统中使用 CGPoint 表示，如果要转换成 id，需要使用 `NSValue` 包装
            let scale = (btn == selectedButton) ? 2 : 0.2
            scaleAnmi.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnmi.duration = 0.5
            btn.pop_add(scaleAnmi, forKey: nil)
            
            // 渐变
            let alphaAnmi:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alphaAnmi.toValue = 0.2
            alphaAnmi.duration = 0.5
            btn.pop_add(alphaAnmi, forKey: nil)
            
            if i == 0 {
                alphaAnmi.completionBlock = { _,_ in
                    
                    // 动画完成 需要回调
                    self.completionBlock?(selectedButton.clsName)
                    
                }
                
            }
            
        }
        
        
        
    }
    
    
    /// 点击更多
    @objc private func clickMore() {
        
        print("点击更多")
        // 将scrollview滚动到第二页
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        // 处理底部按钮
        returnButton.isHidden = false
        
        let margin = scrollView.bounds.width / 6

        closeButtonCenterXCons.constant += margin
        returnButtonCenterXcons.constant -= margin
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
        
        
    }
    
    
    // 关闭视图
    @IBAction func close() {
        
//        removeFromSuperview()
        hiddenButtons()
        
    }
    // 点击返回
    @IBAction func clickReturn(_ sender: UIButton) {
        
        // 返回到首页
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        // 恢复视图
        closeButtonCenterXCons.constant = 0
        returnButtonCenterXcons.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
            
        }) { (_) in
            
            self.returnButton.isHidden = true
            self.returnButton.alpha = 1
        }
        
    }
    
}


// MARK: - 动画扩展
private extension LJComposeTypeView {
    
    // 动画显示当前视图
    func showCurrentView() {
        
        // 创建动画
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        // 添加到视图
        pop_add(anim, forKey: nil)
        // 添加按钮动画
        showButtons()
        
    }
    
    /// 弹力显示所有按钮
    func showButtons() {
        
        let v = scrollView.subviews[0]
        for (i,btn) in v.subviews.enumerated() {
            
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y
            // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
            anim.springBounciness = 8
            // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
            anim.springSpeed = 8
            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            btn.pop_add(anim, forKey: nil)
            
        }
        
    }
    
    
    /// 隐藏当前视图
    func hiddenButtons() {
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        let v = scrollView.subviews[page]
        for (i,btn) in v.subviews.enumerated().reversed() {
            
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
        
            btn.pop_add(anim, forKey: nil)
            
            // 监听动画完成
            if i == 0 {
                
                anim.completionBlock = { _,_ in
                    
                    self.hideCurrentView()
                }
            }
            
        }
        
        
    }
    
    
    func hideCurrentView() {
        
        // 创建动画
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        pop_add(anim, forKey: nil)
        
        // 监听动画完成
        anim.completionBlock = { _,_ in
            
            self.removeFromSuperview()
        }
        
        
    }
    
}


private extension LJComposeTypeView {
    
    func setupUI() {
        // 强行更新布局
        layoutIfNeeded()
        // 向scrollView添加视图
        let rect = scrollView.bounds
        
        let width = scrollView.bounds.width
        
        for i in 0..<2 {
            
            let v = UIView(frame:rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            // 向视图添加按钮
            addButtons(v: v, idx: i * 6)
            // 视图添加到scrollview
            scrollView.addSubview(v)
        }
        
        // 设置scrollView
        scrollView.contentSize = CGSize(width: width * 2, height: 0)
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
    }
    
    
    /// 向v中添加按钮
    ///
    /// - Parameters:
    ///   - v: v
    ///   - idx: 索引
    func addButtons(v:UIView,idx:Int) {
        
        let count = 6
        // 添加6个按钮
        for i in idx..<(idx + count) {
            
            if i >= buttonsInfo.count {
                break
            }
            let dic = buttonsInfo[i]
            guard let imageName = dic["imageName"],
                let title = dic["title"] else{
                    continue
            }
            let btn = LJComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            v.addSubview(btn)
            
            if let actionName = dic["actionName"] {
                // OC 中使用 NSSelectorFromString(@"clickMore")
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }else {
                
                btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            }
            
            btn.clsName = dic["clsName"]
        }
        let btnSize = CGSize(width: 100.0, height: 100.0)
        let margin = (v.bounds.width - 3 *  btnSize.width) / 4
        
        // btn布局
        for (i,btn) in v.subviews.enumerated() {
            let y:CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
        
    }
    
}
