//
//  LJMeiRefreshView.swift
//  shuaxin
//
//  Created by ljkj on 2018/7/24.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJMeiRefreshView: LJRefreshView {

    @IBOutlet weak var buildingIconView: UIImageView!
    @IBOutlet weak var earthIconView: UIImageView!
    @IBOutlet weak var kangarooIconView: UIImageView!
    
    // 父视图高度
    override var parentViewHeight:CGFloat {
        didSet {
            print("父视图高度\(parentViewHeight)")
            
            // 23 - 126
            // 0.2 - 1
            if parentViewHeight < 23 {
                return
            }
            var scale:CGFloat
            if parentViewHeight > 126 {
                scale = 1
            }else{
                scale = 1 - ((126-parentViewHeight)/(126-23))
            }
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
    }
    
    override func awakeFromNib() {
        
        // 房子
        let bImage1 =  UIImage(named:"icon_building_loading_1")
        let bImage2 =  UIImage(named:"icon_building_loading_2")
        buildingIconView.image = UIImage.animatedImage(with: [bImage1!,bImage2!], duration: 0.5)
        
        // 地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = -2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        anim.isRemovedOnCompletion = false
        earthIconView.layer.add(anim, forKey: nil)
        
        // 袋鼠
//        let tImage1 =  UIImage(named:"icon_small_kangaroo_loading_1")
//        let tImage2 =  UIImage(named:"icon_small_kangaroo_loading_2")
//        kangarooIconView.image = UIImage.animatedImage(with: [tImage1!,tImage2!], duration: 0.5)
        // 缩放  需要设置锚点(0 --> 1)
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        // 设置锚点后需要设置frame
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        let centX = self.bounds.width * 0.5
        let centY = self.bounds.height - 23
        kangarooIconView.center = CGPoint(x: centX, y: centY)
        
        
        
        
        
    }
    
    
}
