//
//  LJNewFeatureView.swift
//  testPro
//
//  Created by ljkj on 2018/7/12.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    class func newFeatureView() -> LJNewFeatureView {
        
        let nib = UINib(nibName: "LJNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options:nil)[0] as! LJNewFeatureView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<4 {
            
            let imageName = "new_feature_\(i+1)"
            let imageVi = UIImageView(image: UIImage(named: imageName))
            imageVi.frame = rect.offsetBy(dx: CGFloat(i)*rect.width, dy: 0)
            scrollView.addSubview(imageVi)
        }
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(count + 0), height: 0)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        enterButton.isHidden = true
        pageControl.numberOfPages = count
        
    }
    
}



// MARK: - UIScrollViewDelegate
extension LJNewFeatureView:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        
        if page == scrollView.subviews.count {
            
            removeFromSuperview()
        }
        
        enterButton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        enterButton.isHidden = true
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
        
        pageControl.isHidden = (page == scrollView.subviews.count)
        
    }
    
}
