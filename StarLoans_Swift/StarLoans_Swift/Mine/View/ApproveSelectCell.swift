//
//  ApproveSelectCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ApproveSelectCell: UICollectionViewCell, RegisterCellOrNib {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.RGB(with: 205, green: 205, blue: 205).cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 4, height: 4)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 1//阴影透明度，默认0
        layer.shadowRadius = 2//阴影半径，默认3
        layer.masksToBounds = false//   不设置显示不出阴影
    }

}
