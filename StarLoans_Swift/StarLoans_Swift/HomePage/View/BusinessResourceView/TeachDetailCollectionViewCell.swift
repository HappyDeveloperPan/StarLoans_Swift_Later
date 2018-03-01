//
//  TeachDetailCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/11.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let dataArr:Array<Dictionary<String, Any>> = [
                                                          ["image": #imageLiteral(resourceName: "picture-nenglijiaoxue"), "contentText": "如何提升与客户的沟通能力？(第三期)", "number": "999999已阅读"],
                                                          ["image": #imageLiteral(resourceName: "picture-nenglijiaoxue"), "contentText": "如何提升与客户的沟通能力？(第三期)", "number": "999999已阅读"],
                                                          ["image": #imageLiteral(resourceName: "picture-nenglijiaoxue"), "contentText": "司法考试到货付款说的分离是独立房姐水电费就", "number": "999999已阅读"],
                                                          ["image": #imageLiteral(resourceName: "picture-nenglijiaoxue"), "contentText": "司法考试到货付款说的分离是独立房姐水电费就", "number": "999999已阅读"],
                                                          ["image": #imageLiteral(resourceName: "picture-nenglijiaoxue"), "contentText": "司法考试到货付款说的分离是独立房姐水电费就水电费水电费水电费水电费水电费水电费是否", "number": "999999已阅读"]]

class TeachDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var numberLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        
        contentLB.numberOfLines = 2
        contentLB.sizeToFit()
    }
    
    
}

extension TeachDetailCollectionViewCell {
    func setTeachDetailCellData(with cellData: ResourceModel) {
//        contentLB.text = dataArr[index]["contentText"] as? String
//        leftImg.image = dataArr[index]["image"] as? UIImage
//        numberLB.text = dataArr[index]["number"] as? String
        contentLB.text = cellData.title
        leftImg.setImage(with: picAdress + cellData.image_video)
        numberLB.text = String(cellData.reading_number)
    }
    
    func setCourse(with cellData: ResourceModel) {
        contentLB.text = cellData.title
        leftImg.setImage(with: picAdress + cellData.image_video)
        numberLB.text = String(cellData.reading_number)
    }
    
    func setCellData(with index: Int) {
        contentLB.text = dataArr[index]["contentText"] as? String
        leftImg.image = dataArr[index]["image"] as? UIImage
        numberLB.text = dataArr[index]["number"] as? String
    }
}
