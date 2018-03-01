//
//  VStoreFuncCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class VStoreFuncCollectionViewCell: UICollectionViewCell, RegisterCellOrNib{
    @IBOutlet weak var redPoint: UIView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redPoint.layer.cornerRadius = redPoint.height/2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.RGB(with: 217, green: 217, blue: 217).cgColor
    }
}

extension VStoreFuncCollectionViewCell {
//    func setVStoreFuncCellData(with celldata: String) {
//        
//    }
}
