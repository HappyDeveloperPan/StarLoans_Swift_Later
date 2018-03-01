//
//  ProductDetailCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var topBackImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var leftTopLB: UILabel!
    @IBOutlet weak var leftTopLBWidth: NSLayoutConstraint!
    @IBOutlet weak var auditTypeLB: UILabel!
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var loansNumLB: UILabel!
    
    @IBOutlet weak var centerTitleTop: UILabel!
    @IBOutlet weak var centerContentTop: UILabel!
    @IBOutlet weak var centerTitleCenter: UILabel!
    @IBOutlet weak var centerContentCenter: UILabel!
    @IBOutlet weak var centerTitleBottom: UILabel!
    @IBOutlet weak var centerContentBottom: UILabel!
    
    
    @IBOutlet weak var rightTypeLB: UILabel!
    @IBOutlet weak var rightTypeLB2: UILabel!
    
    @IBOutlet weak var commitBtn: UIButton!
    
    //MARK: - 可操作数据
    var loansProductType: LoansProductType = .selfSupport {
        didSet {
            uploadCellType(loansProductType.rawValue)
        }
    }
    var productModel = ProductModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.RGB(with: 205, green: 205, blue: 205).cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 2, height: 2)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5//阴影透明度，默认0
        layer.shadowRadius = 2//阴影半径，默认3
        layer.masksToBounds = false//   不设置显示不出阴影
        
        //  基本配置
        leftTopLB.layer.borderWidth = 1
        leftTopLB.layer.borderColor = UIColor.white.cgColor
        leftTopLB.layer.cornerRadius = leftTopLB.height/2
        
        rightTypeLB.layer.borderWidth = 0.5
        rightTypeLB.layer.borderColor = kMainColor.cgColor
        rightTypeLB.layer.cornerRadius = 5
        
        rightTypeLB2.layer.borderWidth = 0.5
        rightTypeLB2.layer.borderColor = kMainColor.cgColor
        rightTypeLB2.layer.cornerRadius = 5
        
        loansNumLB.adjustsFontSizeToFitWidth = true
        
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }

    @IBAction func commitBtnClick(_ sender: UIButton) {
        //如果用户没有登录就跳转到登录界面
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        //TODO: - 界面跳转以后修改
//        let vc = LoansDetailViewController.loadStoryboard()
//        vc.loansProductType = loansProductType
//        let topViewController = Utils.currentTopViewController()
//        if topViewController?.navigationController != nil{
//            topViewController?.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            topViewController?.present(vc, animated: true , completion: nil)
//        }
        let vc = AuthorizationViewController.loadStoryboard()
        vc.loansProductType = loansProductType
        vc.url = productModel.url
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}

extension ProductDetailCollectionViewCell {
    func uploadCellType(_ index: Int) {
        if index == 0 {
            centerTitleTop.text = "返佣"
            centerTitleCenter.text = "领取金额"
            centerTitleBottom.text = "已领人数"
            commitBtn.setTitle("领取任务", for: .normal)
        }else {
            centerTitleTop.text = "利率"
            centerTitleCenter.text = "贷款期限"
            centerTitleBottom.text = "交单人数"
            commitBtn.setTitle("申请交单", for: .normal)
        }
    }
    
    func setCellData(_ cellData: Int) {
//        if index == 0 {
////            topBackImg.image = #imageLiteral(resourceName: "ICON-topRedImg")
//            centerTitleTop.text = "返佣"
//            centerTitleCenter.text = "领取金额"
//            centerTitleBottom.text = "已领人数"
//            commitBtn.setTitle("领取任务", for: .normal)
//        }else {
////            topBackImg.image = #imageLiteral(resourceName: "ICON-topRedImg")
//            centerTitleTop.text = "利率"
//            centerTitleCenter.text = "贷款期限"
//            centerTitleBottom.text = "交单人数"
//            commitBtn.setTitle("申请交单", for: .normal)
//        }
    }
    
    func setProductListCellData(with cellData: ProductModel) {
        productModel = cellData
        titleLB.text = cellData.product
        if cellData.card_name.isEmpty {
            leftTopLBWidth.constant = 0
        }else {
            leftTopLBWidth.constant = cellData.card_name.width(CGSize(width: 2000, height: 21), nil) + 12
        }
        leftTopLB.text = cellData.card_name
        logoImg.setImage(with: cellData.cooperation_bank)
        loansNumLB.text = cellData.quota + "万"
        if loansProductType == .selfSupport {
            centerContentTop.text = String(cellData.return_commission) + "%"
            centerContentCenter.text = String(cellData.claim_amount) + "万"
            centerContentBottom.text = String(cellData.leader_number) + "人"
        }else {
            centerContentTop.text = String(cellData.return_commission) + "%"
            centerContentCenter.text = String(cellData.claim_amount) + "年"
            centerContentBottom.text = String(cellData.leader_number) + "人"
        }
        rightTypeLB.isHidden = !cellData.fast_loan.getServiceBool()
        rightTypeLB2.isHidden = cellData.label.isEmpty
        rightTypeLB2.text = cellData.label
    }
}
