//
//  Utils.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

public class Utils {
    ///获取当前页面
    public class func currentTopViewController() -> UIViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
            return currentTopViewController(rootViewController: rootViewController)
        }else{
            return nil
        }
    }
    
    public class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
        if (rootViewController.isKind(of: UITabBarController.self)) {
            let tabBarController = rootViewController as! UITabBarController
            return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
        }
        if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            return currentTopViewController(rootViewController: navigationController.visibleViewController!)
        }
        if ((rootViewController.presentedViewController) != nil) {
            return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
        }
        return rootViewController
    }
    
    ///数据持久化
    class func setAsynchronous(_ object: Any, withKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func clearAsynchronous(withKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getAsynchronousWithKey(_ key: String) -> Any {
        return UserDefaults.standard.value(forKey: key) ?? 0
    }
    
    ///年月日转换
    class func getDateToYMD(with time: TimeInterval) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //        formatter.date(from: "sdfsdf")
        //        let date = NSDate(timeIntervalSince1970: time)
        let date = Date(timeIntervalSince1970: time)
        return formatter.string(from: date)
    }
    
    ///model转json
    class func dataToDictionary(_ data: Data) -> Dictionary<String, Any>? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        } catch _ {
            print("转换失败")
            return nil
        }
    }

}
