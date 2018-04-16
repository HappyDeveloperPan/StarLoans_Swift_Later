//
//  Utils.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation

public enum ControlJumpType {
    case ControlJumpTypePush
    case ControlJumpTypePresent
}

public class Utils {
    
    /// 控制器跳转
    ///
    /// - Parameters:
    ///   - toControl: 需要跳转到的控制器
    ///   - isNav: 跳转到的控制器是否有nav栏
    ///   - jumpType: 跳转类型(push或者present)
    public class func controlJump(_ toControl: UIViewController, isNav: Bool, jumpType: ControlJumpType) {
        let topViewController = Utils.currentTopViewController()
        switch jumpType {
        case .ControlJumpTypePush:
            //如果当前控制器没有nav栏,需要改为present跳转
            if topViewController?.navigationController != nil{
                topViewController?.navigationController?.pushViewController(toControl, animated: true)
            }else{
                if isNav {
                    let navVC = AXDNavigationController(rootViewController: toControl)
                    topViewController?.present(navVC, animated: true , completion: nil)
                }else {
                    topViewController?.present(toControl, animated: true , completion: nil)
                }
            }
        case .ControlJumpTypePresent:
            if isNav {
                let navVC = AXDNavigationController(rootViewController: toControl)
                topViewController?.present(navVC, animated: true , completion: nil)
            }else {
                topViewController?.present(toControl, animated: true , completion: nil)
            }
        }
    }
    
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
    
    class func typeForImageData(for data: NSData) -> String? {
        var c: UInt8 = 0
        data.getBytes(&c, length: 1)
        switch c {
        case 0xff:
            return "jpeg"
        default:
            return "png"
        }
    }

}
