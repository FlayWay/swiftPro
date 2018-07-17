//
//  UIimageView+WebImage.swift
//  testPro
//
//  Created by ljkj on 2018/7/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func lj_setImage(urlString:String?,placeholderImage:UIImage?,isAvatar:Bool = false) {
        
        // 处理 url
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }
        
        /// 可选项只用于swfit
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {[weak self] (image, _, _, _) in
            
            if isAvatar {
                
                self?.image = image?.avatarImage(size: self?.bounds.size)
            }
            
        }
    }
    
}
