//
//  UIViewController+Config.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/24.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func setTopLine(with isHidden: Bool) {
        let navBar = navigationController?.navigationBar
        if isHidden {
            navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navBar?.shadowImage = UIImage()
        }else {
            navBar?.setBackgroundImage(nil, for: .default)
            navBar?.shadowImage = nil
        }
    }
    
    public func setNavigationBarConfig() {
        let navBar = navigationController?.navigationBar
        navBar?.barStyle = .default
        navBar?.barTintColor = .white
        navBar?.tintColor = kTitleColor
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor:kTitleColor]

    }
}



