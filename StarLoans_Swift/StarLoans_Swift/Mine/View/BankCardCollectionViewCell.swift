//
//  BankCardCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/18.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class BankCardCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = kLineColor.cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 2, height: 2)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5//阴影透明度，默认0
        layer.shadowRadius = 2//阴影半径，默认3
        layer.masksToBounds = false//   不设置显示不出阴影
    }

}
