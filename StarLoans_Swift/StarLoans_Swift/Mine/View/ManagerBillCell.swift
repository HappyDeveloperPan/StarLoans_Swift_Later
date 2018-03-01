//
//  ManagerBillCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/7.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ManagerBillCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userTypeLB: UIImageView!
    @IBOutlet weak var loanMoneyLB: UILabel!
    @IBOutlet weak var houseInfoLB: UILabel!
    @IBOutlet weak var carInfoLB: UILabel!
    @IBOutlet weak var salaryInfoLB: UILabel!
    @IBOutlet weak var accountLB: UILabel!              //户口
    @IBOutlet weak var socialSecurityLB: UILabel!       //社保
    @IBOutlet weak var ProvidentFundLB: UILabel!        //公积金
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var disposeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        accountLB.layer.borderWidth = 0.5
        accountLB.layer.borderColor = kMainColor.cgColor
        accountLB.layer.cornerRadius = 5
        socialSecurityLB.layer.borderWidth = 0.5
        socialSecurityLB.layer.borderColor = kMainColor.cgColor
        socialSecurityLB.layer.cornerRadius = 5
        ProvidentFundLB.layer.borderWidth = 0.5
        ProvidentFundLB.layer.borderColor = kMainColor.cgColor
        ProvidentFundLB.layer.cornerRadius = 5
        disposeBtn.layer.cornerRadius = disposeBtn.height/2
        
    }
    
    ///处理按钮
    @IBAction func disposeBtnClick(_ sender: UIButton) {
//        let vc = ManagerBillDetailViewController.loadStoryboard()
        let vc = ManagerBillApprovalOneViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
