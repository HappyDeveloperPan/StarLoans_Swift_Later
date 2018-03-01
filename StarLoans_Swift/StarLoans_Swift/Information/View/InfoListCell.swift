//
//  InfoListCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/1.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class InfoListCell: UITableViewCell, RegisterCellOrNib {
    @IBOutlet weak var infoImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension InfoListCell {
    func setInfoListCellData(with cellData: InfoModel) {
        switch cellData.message_type {
        case 1:
            infoImg.image = #imageLiteral(resourceName: "ICON-xitongxiaoxi")
        case 2:
            infoImg.image = #imageLiteral(resourceName: "ICON-xiaoxiwenzhang")
        default:
            infoImg.image = #imageLiteral(resourceName: "ICON-xitongxiaoxi")
        }
        titleLB.text = cellData.message_title
        contentLB.text = cellData.message_desc
        timeLB.text = Utils.getDateToYMD(with: cellData.message_time)
    }
}
