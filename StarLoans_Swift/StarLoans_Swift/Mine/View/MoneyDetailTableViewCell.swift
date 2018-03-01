//
//  MoneyDetailTableViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/18.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MoneyDetailTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var moneyLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLB.adjustsFontSizeToFitWidth = true
        moneyLB.adjustsFontSizeToFitWidth = true
        leftImg.image = #imageLiteral(resourceName: "ICON-shouru")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
