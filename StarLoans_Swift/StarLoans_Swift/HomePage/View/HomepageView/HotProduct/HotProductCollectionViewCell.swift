//
//  HotProductCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/17.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class HotProductCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var stackOneLB: UILabel!
    @IBOutlet weak var stackTwoLB: UILabel!
    @IBOutlet weak var stackThreeLB: UILabel!
    @IBOutlet weak var stackFourLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackOneLB.adjustsFontSizeToFitWidth = true
        stackTwoLB.adjustsFontSizeToFitWidth = true
        stackThreeLB.adjustsFontSizeToFitWidth = true
        stackFourLB.adjustsFontSizeToFitWidth = true
    }
    
    /// 设置cell数据
    ///
    /// - Parameter cellModel: 所需数据model
    func setHotProductCollectionViewCellData(with cellModel: ProductModel) {
        imgView.image = #imageLiteral(resourceName: "WechatIMG20")
        titleLB.text = cellModel.product
        typeLB.text = "(" + cellModel.producttype + ")"
        stackOneLB.text = String(cellModel.return_commission) + "%"
        stackTwoLB.text = String(cellModel.leader_number) + "人"
        stackThreeLB.text = String(cellModel.claim_amount) + "万"
        stackFourLB.text = String(cellModel.quota) + "万"
    }
}
