//
//  PushBillProductCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/9.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class PushBillProductCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var introLB: UILabel!
    @IBOutlet weak var rebateLB: UILabel!
    @IBOutlet weak var moneyLB: UILabel!
    @IBOutlet weak var numberLB: UILabel!
    @IBOutlet weak var rebateContentLB: UILabel!
    @IBOutlet weak var moneyContentLB: UILabel!
    @IBOutlet weak var numberContentLB: UILabel!
    @IBOutlet weak var commitBtn: AnimatableButton!
    
    //MARK: - 可操作数据
    var productModel = ProductModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.RGB(with: 205, green: 205, blue: 205).cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 2, height: 2)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 1//阴影透明度，默认0
        layer.shadowRadius = 2//阴影半径，默认3
        layer.masksToBounds = false//   不设置显示不出阴影
        
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }

    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        let vc = AuthorizationViewController.loadStoryboard()
        vc.productId = productModel.product_id
        vc.url = productModel.url
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}

extension PushBillProductCell {
    func setBillProductCell(_ celldata: ProductModel) {
        productModel = celldata
        if celldata.img.isEmpty {
            backImg.image = #imageLiteral(resourceName: "ICON-diban1")
        }else {
            backImg.setImage(with: celldata.img)
        }
        titleLB.text = celldata.product
        introLB.text = celldata.desc
        rebateContentLB.text = String(celldata.return_commission) + "%"
        moneyContentLB.text = String(celldata.quota) + "万"
        numberContentLB.text = String(celldata.leader_number) + "人"
    }
}
