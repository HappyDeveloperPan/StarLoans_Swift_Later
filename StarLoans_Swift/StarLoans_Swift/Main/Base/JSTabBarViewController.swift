//
//  JSTabBarViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class JSTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        delegate = self
        addChildViewControllers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addChildViewControllers()  {
        
        addChildViewController(childViewController: HomePageViewController(), title: "首页", imageName: "ICON-homepage",
            selectedImageName: "ICON-homepage-select")
        addChildViewController(childViewController: LoansViewController(), title: "贷款", imageName: "ICON-homepage",
            selectedImageName: "ICON-homepage-select")
        addChildViewController(childViewController: PushViewController(), title: "推单", imageName: "ICON-homepage", selectedImageName: "ICON-homepage-select")
        addChildViewController(childViewController: InformationViewController(), title: "消息", imageName: "ICON-homepage", selectedImageName: "ICON-homepage-select")
        addChildViewController(childViewController: MineViewController(), title: "我的", imageName: "ICON-homepage", selectedImageName: "ICON-homepage-select")
        
    }
    
    /// tabbar添加子控制器
    ///
    /// - Parameters:
    ///   - childViewController: 子控制器
    ///   - title: 控制器标题
    ///   - imageName: tabbar图片
    ///   - selectedImageName: tabbar选中图片
    
    private func addChildViewController(childViewController: UIViewController,
                                        title: String,
                                        imageName: String,
                                        selectedImageName: String) {
        childViewController.title = title
        childViewController.tabBarItem.image = UIImage(named:imageName)
        childViewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        let nav = UINavigationController(rootViewController:childViewController)
        addChildViewController(nav)
    }
    
    ///跳转到登录界面
    func notifPresentLogin(notif:NSNotification?) {
        var selectNavVC = selectedViewController as? UINavigationController
        if selectNavVC?.presentedViewController != nil {
            selectNavVC = selectNavVC?.presentedViewController as? UINavigationController
        }
        let loginVC = LoginViewController()
//        let navVC = UINavigationController(rootViewController: loginVC as? UIViewController ?? UIViewController())
        let navVC = UINavigationController(rootViewController: loginVC)
        selectNavVC?.present(navVC, animated: true, completion: {
            
        })
    }
    
}

extension JSTabBarViewController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if (viewControllers?.contains(viewController))! && viewControllers!.index(of: viewController)! >= 4 {
            notifPresentLogin(notif: nil)
            return false
        }
        return true
    }
}

