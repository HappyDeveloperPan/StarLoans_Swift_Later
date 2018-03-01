//
//  ClientListDetailCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class ClientListDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberListLB: UILabel!
    @IBOutlet weak var imaginaryLine: UIImageView!
    @IBOutlet weak var numberLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        imaginaryLine.drawImaginaryLine(with: UIColor.RGB(with: 205, green: 205, blue: 205))
    }
    
}
