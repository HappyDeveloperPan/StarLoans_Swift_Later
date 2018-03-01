//
//  AppDelegate+System.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/21.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

extension AppDelegate {
    public func setupGlobalConfig() {
        //导航栏和tab栏的全局配置
        let navBar = UINavigationBar.appearance()
        navBar.barStyle = UIBarStyle.default
//        navBar.isTranslucent = false
//        navBar.tintColor = UIColor.white
//        navBar.barTintColor = kMainColor
//        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//
//
//        let tabBar = UITabBar.appearance()
//        tabBar.isTranslucent = false
        //键盘监听
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        //
        IQKeyboardManager.sharedManager().canAdjustAdditionalSafeAreaInsets = true
    }
}
