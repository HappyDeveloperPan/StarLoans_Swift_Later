//
//  ComboBoxModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ComboBoxModel: NSObject {
    struct Keys {
        static let occupation = "occupation"                //客户资源--职业
        static let payment_type = "payment_type"            //客户资源--工资发放形式
        static let house_type = "house_type"                //客户资源--房产类型
        static let car_type = "car_type"                    //客户资源--车产类型
        static let credit = "credit"                        //客户资源--信用情况
        static let loan_type = "loan_type"                  //产品资源--贷款类型
        static let quickbill_valid_period = "quickbill_valid_period"    //有效期限
    }
    
    public var occupation: [Any] = [Any]()
    public var payment_type: [Any] = [Any]()
    public var house_type: [Any] = [Any]()
    public var car_type: [Any] = [Any]()
    public var credit: [Any] = [Any]()
    public var loan_type: [Any] = [Any]()
    public var quickbill_valid_period: [Any] = [Any]()
    
    public init(with json:JSON) {
        let appInfo = json
        self.occupation = appInfo[Keys.occupation].arrayObject ?? [String]()
        self.payment_type = appInfo[Keys.payment_type].arrayObject ?? [String]()
        self.house_type = appInfo[Keys.house_type].arrayObject ?? [String]()
        self.car_type = appInfo[Keys.car_type].arrayObject ?? [String]()
        self.credit = appInfo[Keys.credit].arrayObject ?? [String]()
        self.loan_type = appInfo[Keys.loan_type].arrayObject ?? [String]()
        self.quickbill_valid_period = appInfo[Keys.quickbill_valid_period].arrayObject ?? [String]()
    }
    
    override init() {
        super .init()
    }
}
