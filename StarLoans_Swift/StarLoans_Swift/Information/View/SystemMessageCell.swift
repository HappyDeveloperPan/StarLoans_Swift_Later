//
//  SystemMessageCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class SystemMessageCell: UITableViewCell, RegisterCellOrNib {
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLB.adjustsFontSizeToFitWidth = true
        contentLB.sizeToFit()
        contentLB.numberOfLines = 0
        
        contentLB.text = "这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容这里面显示消息的一些内容"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
