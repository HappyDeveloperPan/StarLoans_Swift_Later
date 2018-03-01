//
//  CustomFlowLayout.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class VStoreCustomFlowLayout: UICollectionViewFlowLayout {
    var maximumInteritemSpacing: CGFloat = 8
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//        //第0个cell没有上一个cell，所以从1开始
//        if let array = attributes {
//            for i in 1...array.count-1 {
//                //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
//                let curAttr: UICollectionViewLayoutAttributes = array[i]
//                let preAttr: UICollectionViewLayoutAttributes = array[i - 1]
//                let origin: CGFloat = preAttr.frame.maxX
//                //根据  maximumInteritemSpacing 计算出的新的 x 位置
//                let targetX = origin + maximumInteritemSpacing
//                // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
//                if curAttr.frame.minX > targetX {
//                    // 换行时不用调整
//                    if (targetX + curAttr.frame.width) < collectionViewContentSize.width {
//                        var frame: CGRect = curAttr.frame
//                        frame.origin.x = targetX
//                        curAttr.frame = frame
//                    }
//                }
//            }
//        }
////        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
////    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        if indexPath.row%3 == 0 {
            var frame = attributes.frame
            frame = CGRect(x: frame.midX, y: frame.minY,  width: frame.width, height: frame.height)
            attributes.frame = frame
        }
        return attributes
    }
    
}
