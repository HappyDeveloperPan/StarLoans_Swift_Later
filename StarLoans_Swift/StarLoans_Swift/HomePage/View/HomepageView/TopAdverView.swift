//
//  TopAdverView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/30.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

@objc protocol TopAdverViewDelegate {
    /// 点击图片回调
    func topAdverViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    /// 图片滚动回调
    func topAdverViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
}

class TopAdverView: WRCycleScrollView {
    
    weak var adverDelegate:TopAdverViewDelegate?
    
    override init(frame: CGRect, type:ImgType = .SERVER, imgs:[String]? = nil, descs:[String]? = nil, defaultDotImage:UIImage? = nil, currentDotImage:UIImage? = nil, placeholderImage:UIImage? = nil) {
        super .init(frame: frame, type: type, imgs: imgs, descs: descs, defaultDotImage: defaultDotImage, currentDotImage: currentDotImage, placeholderImage: placeholderImage)
        delegate = self
        pageControlAliment = .CenterBottom
        currentDotColor = kMainColor
        otherDotColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TopAdverView: WRCycleScrollViewDelegate {
    /// 点击图片回调
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        adverDelegate?.topAdverViewDidSelect(at: index, cycleScrollView: cycleScrollView)
    }
    
    /// 图片滚动回调
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        adverDelegate?.topAdverViewDidScroll(to: index, cycleScrollView: cycleScrollView)
    }
}
