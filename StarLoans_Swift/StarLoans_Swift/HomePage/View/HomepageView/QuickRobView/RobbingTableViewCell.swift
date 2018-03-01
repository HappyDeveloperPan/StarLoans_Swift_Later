//
//  RobbingTableViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/6.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class RobbingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userTypeImg: UIImageView!
    @IBOutlet weak var pledgeTypeLB: UILabel!
    @IBOutlet weak var moneyLB: UILabel!
    @IBOutlet weak var robbingBtn: UIButton!
    @IBOutlet weak var lbTypeBtn: UILabel!
    @IBOutlet weak var cbTypeBtn: UILabel!
    @IBOutlet weak var rbTypeBtn: UILabel!
    @IBOutlet weak var needDayBtn: UILabel!
    @IBOutlet weak var houseInfoLB: UILabel!
    @IBOutlet weak var carInfoLB: UILabel!
    @IBOutlet weak var incomeLB: UILabel!
    
    //MARK: - 内部数据
    fileprivate var clientInfoModel = ClientInfoModel()
    
    //MARK: - 生命周期
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        moneyLB.adjustsFontSizeToFitWidth = true
        pledgeTypeLB.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        pledgeTypeLB.layer.cornerRadius = 10.5
        robbingBtn.layer.cornerRadius = robbingBtn.height/2
        lbTypeBtn.layer.borderWidth = 0.5
        lbTypeBtn.layer.borderColor = kMainColor.cgColor
        lbTypeBtn.layer.cornerRadius = 5
        cbTypeBtn.layer.borderWidth = 0.5
        cbTypeBtn.layer.borderColor = kMainColor.cgColor
        cbTypeBtn.layer.cornerRadius = 5
        rbTypeBtn.layer.borderWidth = 0.5
        rbTypeBtn.layer.borderColor = kMainColor.cgColor
        rbTypeBtn.layer.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let vc = PayViewController.loadStoryboard()
        vc.price = Float(clientInfoModel.client_price)
        vc.goodsId = clientInfoModel.client_id
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}

extension RobbingTableViewCell {
    func setQuickRobData(with cellData: ClientInfoModel) {
        clientInfoModel = cellData
        userNameLB.text = cellData.client_name
        userTypeImg.image = cellData.getTypeImage()
        pledgeTypeLB.text = cellData.getpledgeType()
//        moneyLB.text = String(cellData.client_loan_need/10000) + "万"
        if cellData.client_loan_need >= 10000 {
            moneyLB.text = String(cellData.client_loan_need/10000) + "万"
        }else {
            moneyLB.text = String(cellData.client_loan_need) + "元"
        }
        houseInfoLB.text = cellData.getHouseInfo()
        carInfoLB.text = cellData.getCarInfo()
        incomeLB.text = "月收入" + String(cellData.client_month_income)
        lbTypeBtn.isHidden = !cellData.client_is_shenzhen_census.getServiceBool()
        cbTypeBtn.isHidden = !cellData.client_is_social_security.getServiceBool()
        rbTypeBtn.isHidden = !cellData.client_is_accumulated_funds.getServiceBool()
        needDayBtn.text = "需求程度" + String(cellData.client_days_need) + "天"
        robbingBtn.setTitle(String(cellData.client_price) + "元抢单", for: .normal)
    }
}
