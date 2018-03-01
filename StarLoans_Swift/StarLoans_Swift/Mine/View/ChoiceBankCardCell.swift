//
//  ChoiceBankCardCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/24.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ChoiceBankCardCell: UITableViewCell, RegisterCellOrNib {
    @IBOutlet weak var bankCardImg: UIImageView!
    @IBOutlet weak var bankNameLB: UILabel!
    @IBOutlet weak var bankInfoLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ChoiceBankCardCell {
    func setBankCardCellData(_ cellData: UserModel) {
        if !cellData.logo_small.isEmpty {
            bankCardImg.setImage(with: cellData.logo_small)
        }
        bankNameLB.text = cellData.bank_full
        bankInfoLB.text = "尾号" + cellData.last_four + cellData.card_type
    }
}
