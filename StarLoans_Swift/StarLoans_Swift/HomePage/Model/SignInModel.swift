//
//  SignInModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//total_point    int(11)    累计签到积分
//is_sign    tinyint(3)    今天是否签到，0未签到，1已签到
//sign_accumulate_days    tinyint(3)    累计签到天数
//sign_date    int(32)    登录日期


class SignInModel: NSObject {
    struct Keys {
        static let total_point = "total_point"
        static let is_sign = "is_sign"
        static let sign_accumulate_days = "sign_accumulate_days"
        static let sign_date = "sign_date"
    }
    
    public var total_point: Int = 0
    public var is_sign: Bool = false
    public var sign_accumulate_days: Int = 0
    public var sign_date: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.total_point = appInfo[Keys.total_point].intValue
        self.is_sign = appInfo[Keys.is_sign].boolValue
        self.sign_accumulate_days = appInfo[Keys.sign_accumulate_days].intValue
        self.sign_date = appInfo[Keys.sign_date].stringValue
    }
    
    override init() {
        super .init()
    }
}
