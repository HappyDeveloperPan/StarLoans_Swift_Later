//
//  CommonProblemCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/2/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class CommonProblemCell: UITableViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var titleLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLB.sizeToFit()
        titleLB.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CommonProblemCell {
    func setCommonProblemCellData(_ cellData: UserModel) {
        titleLB.text = cellData.question
    }
}
