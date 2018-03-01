//
//  AppDelegate.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - 可操作数据
    var window: UIWindow?
    var allowRotation: Bool = false

    //MARK: - 生命周期
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ///     微信注册
        WXApi.registerApp(WXAppID, enableMTA: true)
        ///     极光注册
        //注册通知实体
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) |  Int(JPAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        //注册极光推送
        JPUSHService.setup(withOption: launchOptions, appKey: JPushAppKey, channel: "YinHao channel", apsForProduction: false)
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                print("registrationID获取成功：\(String(describing: registrationID))")
                if let registrationID = registrationID {
                    Utils.setAsynchronous(registrationID, withKey: kRegistrationID)
                }
//                Utils.setAsynchronous(String(describing: registrationID), withKey: kRegistrationID)
            }else {
                print("registrationID获取失败：\(resCode)")
            }
        }
        ///     自动登录
        if let userDic = Utils.getAsynchronousWithKey(kSavedUser) as? Dictionary<String, Any>{
            
            UserManager.shareManager.userModel = UserModel(with: JSON(userDic))
            
            let parameters = ["token": UserManager.shareManager.userModel.token] as [String : AnyObject]
            
            NetWorksManager.requst(with: kUrl_AutoLogin, type: .post, parameters: parameters, completionHandler: { (jsonData, error) in
                if jsonData?["status"] == 200 {
                    UserManager.shareManager.isLogin = true
                    if let data = jsonData?["data"] {
                        UserManager.shareManager.userModel = UserModel(with: data)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
                }else {
                    if error == nil {
                        if let msg = jsonData?["msg_zhcn"].stringValue {
                            JSProgress.showFailStatus(with: msg)
                        }
                    }else {
                        JSProgress.showFailStatus(with: "请求失败")
                    }
                }
            })
        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        //得到当前应用的版本号
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        print("当前版本号: \(currentAppVersion)")
        //取出之前保存的版本号
        let oldAppVersion = Utils.getAsynchronousWithKey(kRunVersion) as? String
        print("老版本号: \(String(describing: oldAppVersion))")
        if oldAppVersion == nil || oldAppVersion != currentAppVersion {
            Utils.setAsynchronous(currentAppVersion, withKey: kRunVersion)
            window?.rootViewController = WelcomeViewController()
        }else {
            window?.rootViewController = AXDTabBarViewController()
        }
        window?.makeKeyAndVisible()
        setupGlobalConfig()
        
        return true

    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("openURL:\(url.absoluteString)")
        if url.scheme == WXAppID {
            return WXApi.handleOpen(url, delegate: self)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotation{
            return [UIInterfaceOrientationMask.landscapeLeft, UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.portrait]
        }
        return UIInterfaceOrientationMask.portrait
    }
    
    //MARK: - 推送相关
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("\("极光DeviceToken: \(deviceToken.hashValue)")")
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        NotificationCenter.defaultCenter().postNotificationName(JuPushNotificationName, object: nil, userInfo: userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
//        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }

}

//MARK: - WXApiDelegate代理
extension AppDelegate: WXApiDelegate {
    ///微信支付回调结果
    func onResp(_ resp: BaseResp!) {
        if resp .isKind(of: PayResp.self) {
            switch resp.errCode {
            case WXErrCodeUnsupport.rawValue...WXSuccess.rawValue:            /*支付成功*/
                ///支付成功需要回调服务器
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWechatPayResult), object: resp.errCode)
//            case WXErrCodeCommon.rawValue:      /*普通错误类型*/
//                break
//            case WXErrCodeUserCancel.rawValue:  /*用户点击取消*/
//                break
//            case WXErrCodeSentFail.rawValue:    /*发送失败*/
//                break
//            case WXErrCodeAuthDeny.rawValue:    /*授权失败*/
//                break
//            case WXErrCodeUnsupport.rawValue:   /*微信不支持*/
//                break
            default: break
            }
        }
    }
}

//MARK: - 极光推送代理
extension AppDelegate: JPUSHRegisterDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler();
        // 应用打开的时候收到推送消息
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: NotificationObject_Sueecess, userInfo: userInfo)
    }
    
    
}


