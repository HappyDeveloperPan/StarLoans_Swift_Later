//
//  RobMonadViewCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/17.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class RobMonadViewCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    /// 贷款需求
    @IBOutlet weak var loanNeedLB: UILabel!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var sexImg: UIImageView!
    @IBOutlet weak var userTypeImg: UIImageView!
    @IBOutlet weak var robMonadBtn: AnimatableButton!
    @IBOutlet weak var stackOneLB: UILabel!
    @IBOutlet weak var stackTwoLB: UILabel!
    @IBOutlet weak var stackThreeLB: UILabel!
    @IBOutlet weak var stackFourLB: UILabel!
    
    var robMonadBtnCallBack:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// 设置cell数据
    ///
    /// - Parameter cellModel: 所需数据model
    func setRobMonadViewCollectionViewCellData(with cellModel: ClientInfoModel) {
        var text: String = ""
        if cellModel.client_loan_need >= 10000 {
            text = String(cellModel.client_loan_need/10000) + "万"
//            loanNeedLB.text = String(cellModel.client_loan_need/10000) + "万"
        }else {
            text = String(cellModel.client_loan_need) + "元"
//            loanNeedLB.text = String(cellModel.client_loan_need) + "元"
        }
        let attriText = NSMutableAttributedString(string: text)
        let count = text.count
        attriText.addAttributes([NSAttributedStringKey.obliqueness: 0.3], range: NSMakeRange(count-1, 1))
        attriText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)], range: NSMakeRange(count-1, 1))
        loanNeedLB.attributedText = attriText
        
        nameLB.text = cellModel.client_name
        sexImg.image = cellModel.getSexImage()
        userTypeImg.image = cellModel.getTypeImage()
        stackOneLB.text = cellModel.getHouseInfo()
        stackTwoLB.text = cellModel.getCarInfo()
        stackThreeLB.text = "月收入" + String(cellModel.client_month_income/1000) + "K"
        robMonadBtn.setTitle(String(cellModel.client_price) + "元抢单", for: .normal)
    }

    // MARK: - 控件点击事件
    @IBAction func robMonadBtnClick(_ sender: AnimatableButton) {
        robMonadBtnCallBack!()
    }
}
