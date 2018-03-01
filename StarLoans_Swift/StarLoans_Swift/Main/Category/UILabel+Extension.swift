//
//  UILabel+Extension.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/25.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import CoreText


extension UILabel {
    ///设置label左右对齐
    func textAlignmentLeftAndRight() {
        let size = text?.boundingRect(with: CGSize(width: frame.width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil).size
        let margin: CGFloat = (frame.width - size!.width) / CGFloat((text?.count)! - 1)
        let number = margin
        let attribute = NSMutableAttributedString(string: text!)
        attribute.addAttribute(NSAttributedStringKey.kern, value: number, range: NSRange(location: 0, length: (text?.count)! - 1))
        attributedText = attribute
    }
}
