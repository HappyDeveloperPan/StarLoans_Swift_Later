//
//  QSShareButton.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/11.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class QSShareButton: UIButton {

    override init(frame: CGRect) {
        super .init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.black, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let retValue = CGRect(x: 0, y: self.frame.size.height - 25, width: contentRect.size.width, height: 25)
        return retValue
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let retValue = CGRect(x: self.frame.size.width/2-30, y: 5, width: 60, height: 60)
        return retValue
    }
    
}
