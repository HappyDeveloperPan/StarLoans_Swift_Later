//
//  MineHeaderView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/15.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MineHeaderView: UIView, LoadNibProtocol {
    //  用户名
    @IBOutlet weak var userNameBtn: UIButton!
    @IBOutlet weak var userNameBtnTop: NSLayoutConstraint!
    //  用户头像
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userImgTop: NSLayoutConstraint!
    //  用户认证
    @IBOutlet weak var approveImg: UIImageView!
    @IBOutlet weak var approveLB: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super .layoutSubviews()
        userNameBtnTop.constant = kStatusHeight + 10
        userImgTop.constant = kStatusHeight + 8
    }
}
