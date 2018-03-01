//
//  LoginViewModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/24.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewModel: NSObject {
    
    var userModel:UserModel? //     用户数据
    
    /// 用户登录
    ///
    /// - Parameters:
    ///   - phoneNumber: 电话号码
    ///   - password: 密码
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func login(with phoneNumber: String, password: String, success: @escaping (_ userModel: UserModel)->(), failture: @escaping (_ error : Error)->()) {
        
        let urlString = "http://www.yituinfo.cn/Patrolling/interface/leader/query/leaderLogin.do"
        let parameters = ["phoneNumber": phoneNumber,
                          "password": password ]
        
        NetWorksManager.requst(with: urlString, type: .post, parameters: parameters, success: { (response) in
            //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
            if let value = response as? [String: AnyObject] {
                UserManager.shareManager.userModel = UserModel(with: JSON(value))
                success(UserModel(with: JSON(value)))
                print(UserModel(with: JSON(value)))
            }
        }) { (error) in
            failture(error)
        }
    }
    
    
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - phoneNumber: 手机号
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func getVerCode(with phoneNumber: String, success: @escaping (_ userModel: UserModel)->(), failture: @escaping  (_ error: Error)->()) {
        
        let parameters = ["user": phoneNumber]
        
        NetWorksManager.requst(with: kUrl_GetCode, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
//               let userModel  = UserModel(with: jsonData!["Data"])
            }else {
                if error == nil {
                    JSProgress.showFailStatus(with: jsonData!["msg"].stringValue)
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
            
        }
    }
    
    /// 手机验证
    ///
    /// - Parameters:
    ///   - phoneNumber: 手机号
    ///   - verCode: 验证码
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func phoneVerify(with phoneNumber: String, verCode: String, success: @escaping (_ userModel: UserModel)->(), failture: @escaping  (_ error: Error)->()) {
        
        let urlString = "http://www.yituinfo.cn/Patrolling/interface/leader/query/leaderLogin.do"
        let parameters = ["phoneNumber": phoneNumber,
                          "password": verCode ]
        
        NetWorksManager.requst(with: urlString, type: .post, parameters: parameters, success: { (response) in
            //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
            if let value = response as? [String: AnyObject] {
                UserManager.shareManager.userModel = UserModel(with: JSON(value))
                success(UserModel(with: JSON(value)))
                print(UserModel(with: JSON(value)))
            }
        }) { (error) in
            failture(error)
        }
    }
    
    //注册
    
    //找回密码
}
