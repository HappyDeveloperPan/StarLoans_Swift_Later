//
//  LoansModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoansModel: NSObject {
    struct Keys {
        static let occupation = "occupation"                //客户资源--职业
        static let payment_type = "payment_type"            //客户资源--工资发放形式
        static let house_type = "house_type"                //客户资源--房产类型
        static let car_type = "car_type"                    //客户资源--车产类型
        static let credit = "credit"                        //客户资源--信用情况
        static let loan_type = "loan_type"                  //产品资源--贷款类型
    }
    
    public var occupation: [JSON] = [JSON]()
    public var payment_type: [JSON] = [JSON]()
    public var house_type: [JSON] = [JSON]()
    public var car_type: [JSON] = [JSON]()
    public var credit: [JSON] = [JSON]()
    public var loan_type: [JSON] = [JSON]()
    
    public init(with json:JSON) {
        let appInfo = json
        self.occupation = appInfo[Keys.occupation].arrayValue
        self.payment_type = appInfo[Keys.payment_type].arrayValue
        self.house_type = appInfo[Keys.house_type].arrayValue
        self.car_type = appInfo[Keys.car_type].arrayValue
        self.credit = appInfo[Keys.credit].arrayValue
        self.loan_type = appInfo[Keys.loan_type].arrayValue
    }
    
    override init() {
        super .init()
    }
}
