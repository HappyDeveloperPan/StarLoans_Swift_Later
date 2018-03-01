//
//  BrokerClientCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/26.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class BrokerClientCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var productNameLB: UILabel!
    @IBOutlet weak var auditType: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var loanNumLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var houseLB: UILabel!
    @IBOutlet weak var carLB: UILabel!
    @IBOutlet weak var salaryLB: UILabel!
    @IBOutlet weak var loanPledgeLB: AnimatableLabel!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var commitBtn: AnimatableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
    }

    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
    }
}
