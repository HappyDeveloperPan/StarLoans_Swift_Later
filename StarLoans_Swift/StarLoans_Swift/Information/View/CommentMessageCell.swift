//
//  CommentMessageCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class CommentMessageCell: UITableViewCell, RegisterCellOrNib {
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var productBtn: UIButton!
    @IBOutlet weak var productWidth: NSLayoutConstraint!
    @IBOutlet weak var replyTV: AnimatableTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productBtn.setTitle("产品名称: 宅e贷", for: .normal)
        productBtn.layer.cornerRadius = 5
        if (productBtn.titleLabel?.text?.width(CGSize(width: 2000, height: 20), nil))! + 20 < kScreenWidth - 66 {
            productWidth.constant = (productBtn.titleLabel?.text?.width(CGSize(width: 2000, height: 20), nil))! + 20
        }else {
            productWidth.constant = kScreenWidth - 66
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        endEditing(true)
        replyTV.text = ""
    }
    @IBAction func publish(_ sender: UIButton) {
        
    }
}
