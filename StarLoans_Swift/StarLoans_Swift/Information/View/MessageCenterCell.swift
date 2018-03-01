//
//  MessageCenterCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class MessageCenterCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var redPoint: AnimatableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.RGB(with: 217, green: 217, blue: 217).cgColor
    }
    
    func setMessageCenterCellData(_ image: UIImage, content: String) {
        contentLB.text = content
        img.image  = image
    }

}
