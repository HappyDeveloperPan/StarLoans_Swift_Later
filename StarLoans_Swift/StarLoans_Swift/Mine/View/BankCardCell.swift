//
//  BankCardCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/24.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

protocol BankCardCellDelegate: class{
    func removeCell(_ cell: UICollectionViewCell)
}

class BankCardCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankCardType: UILabel!
    @IBOutlet weak var fourNumLB: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    weak var delegate: BankCardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.RGB(with: 226, green: 90, blue: 94)
        layer.cornerRadius = 5
        layer.shadowColor = kLineColor.cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 2, height: 2)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5//阴影透明度，默认0
        layer.shadowRadius = 2//阴影半径，默认3
        layer.masksToBounds = false//   不设置显示不出阴影
    }

    @IBAction func deleteBtnClick(_ sender: UIButton) {
        delegate?.removeCell(self)
    }
}
