//
//  AXDTabBarViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import ESTabBarController_swift

public let kPresentLogin = "presentLogin"

class AXDTabBarViewController: ESTabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        NotificationCenter.default.addObserver(self, selector: #selector(notifPresentLogin(notif:)), name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
        addChildViewControllers()
        shouldHijackHandler = { tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            if index == 3 && !UserManager.shareManager.isLogin {
                return true
            }
            return false
        }
        didHijackHandler = { [weak self] tabbarController, viewController, index in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let pushNav = AXDNavigationController(rootViewController: PushViewController())
//                self?.present(pushNav, animated: true, completion: nil)
//            }
            if index == 2 {
//                let pushNav = AXDNavigationController(rootViewController: PushViewController())
//                self?.present(pushNav, animated: true, completion: nil)
                let blurEffect = UIBlurEffect(style: .extraLight)
                //接着创建一个承载模糊效果的视图
                let blurView = PushBillView(effect: blurEffect)
                //设置模糊视图的大小（全屏）
                blurView.frame.size = (self?.view.size)!
                //添加模糊视图到页面view上（模糊视图下方都会有模糊效果)
                self?.view.addSubview(blurView)
                blurView.alpha = 0
                UIView.animate(withDuration: 0.5, animations: {
                    blurView.alpha = 1
                }) { (finish) in
                }
            }
            if index == 3 {
                self?.notifPresentLogin(notif: nil)
            }
            
        }
    }
    
    private func addChildViewControllers()  {
        
        let contro1 = HomePageViewController()
        contro1.title = ""
        contro1.tabBarItem = ESTabBarItem(AXDTabBarItemContentView(), title: "首页", image: #imageLiteral(resourceName: "ICON-homepage"), selectedImage: #imageLiteral(resourceName: "ICON-homepage-select"))
        let nav1 = AXDNavigationController(rootViewController: contro1)
        
        let contro2 = LoansViewController()
        contro2.title = ""
        contro2.tabBarItem = ESTabBarItem(AXDTabBarItemContentView(), title: "贷款", image: #imageLiteral(resourceName: "ICON-loans"), selectedImage: #imageLiteral(resourceName: "ICON-loans-select"))
        let nav2 = AXDNavigationController(rootViewController: contro2)
        
        let contro3 = PushViewController()
        contro3.tabBarItem = ESTabBarItem(AXDIrregularityTabBarItemContentView(), title: nil, image: #imageLiteral(resourceName: "ICON-tuidan"), selectedImage: #imageLiteral(resourceName: "ICON-tuidan"))
        let nav3 = AXDNavigationController(rootViewController: contro3)
        
//        let contro4 = InformationViewController()
        let contro4 = MessageCenterViewController()
        contro4.title = ""
        contro4.tabBarItem = ESTabBarItem(AXDTabBarItemContentView(), title: "消息", image: #imageLiteral(resourceName: "ICON-xiaoxi"), selectedImage: #imageLiteral(resourceName: "ICON-xiaoxi-select"))
        let nav4 = AXDNavigationController(rootViewController: contro4)
        
        let contro5 = MineViewController.loadStoryboard()
        contro5.title = ""
        contro5.tabBarItem = ESTabBarItem(AXDTabBarItemContentView(), title: "我的", image: #imageLiteral(resourceName: "ICON-mine"), selectedImage: #imageLiteral(resourceName: "ICON-mine-select"))
        let nav5 = AXDNavigationController(rootViewController: contro5)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    
    ///跳转到登录界面
    @objc func notifPresentLogin(notif:NSNotification?) {
        var selectNavVC = selectedViewController as? UINavigationController
        if selectNavVC?.presentedViewController != nil {
            selectNavVC = selectNavVC?.presentedViewController as? UINavigationController
        }
        let loginVC = LoginViewController()
//        let navVC = AXDNavigationController(rootViewController: loginVC as? UIViewController ?? UIViewController())
        let navVC = AXDNavigationController(rootViewController: loginVC)
//        selectNavVC?.present(navVC, animated: true, completion: {
//
//        })
        selectNavVC?.present(navVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}

//extension AXDTabBarViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        print(viewController)
//        if (viewControllers?.contains(viewController))! && viewControllers!.index(of: viewController)! == 3 {
//            notifPresentLogin(notif: nil)
//
//            return false
//        }
//        return true
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("\(viewController)")
//        print("\(String(describing: viewControllers?.index(of: viewController)))")
//    }
//
//}




