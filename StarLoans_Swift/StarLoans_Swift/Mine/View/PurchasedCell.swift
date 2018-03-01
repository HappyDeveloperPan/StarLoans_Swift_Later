//
//  PurchasedCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PurchasedCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var isBuyLB: UILabel!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        detailBtn.layer.cornerRadius = detailBtn.height/2
    }

    @IBAction func detailBtnClick(_ sender: UIButton) {
        //跳转到详情界面
        let vc = PurchasedCourseDetailViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
