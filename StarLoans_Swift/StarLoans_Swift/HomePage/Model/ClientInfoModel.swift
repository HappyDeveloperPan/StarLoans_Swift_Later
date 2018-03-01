//
//  ClientInfoModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/23.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//client_id    int(11)    客户ID
//client_name    varchar(50)    客户姓名
//client_type    tinyint(3)    客户分类，1精准客户，2优质客户
//client_mortgage_asset    tinyint(3)    抵押资产，1房屋抵押，2车辆抵押
//client_loan_need    decimal(10,2)    贷款需求
//client_house_type    tinyint(3)    房产类型,1无房2有贷款房3有红本房4有小产权房
//client_car_type    tinyint(3)    车产类型,1无车2有全款车3有贷款车
//client_month_income        decimal(10,2)    月收入
//client_income_payment_type    tinyint(3)    发放形式,1代发工资
//client_is_shenzhen_census    tinyint(3)    是否深户，2是1否
//client_is_accumulated_funds    tinyint(3)    是否有公积金，2是1否
//client_is_social_security    tinyint(3)    是否有社保，2是1否
//client_price    decimal(10,2)    客户信息售价
//client_days_need    int(11)    需求程度（天数）

class ClientInfoModel: NSObject {
    struct Keys {
        static let client_id = "client_id"
        static let client_name = "client_name"
        static let client_type = "client_type"
        static let client_type_name = "client_type_name"
        static let client_mortgage_asset = "client_mortgage_asset"
        static let client_loan_need = "client_loan_need"
        static let client_house_type = "client_house_type"
        static let client_house_type_name = "client_house_type_name"
        static let client_car_type = "client_car_type"
        static let client_car_type_name = "client_car_type_name"
        static let client_month_income = "client_month_income"
        static let client_income_payment_type = "client_income_payment_type"
        static let client_income_payment_type_name = "client_income_payment_type_name"
        static let client_is_shenzhen_census = "client_is_shenzhen_census"
        static let client_is_accumulated_funds = "client_is_accumulated_funds"      //公积金
        static let client_is_social_security = "client_is_social_security"
        static let client_price = "client_price"
        static let client_days_need = "client_days_need"
        static let client_loan_period = "client_loan_period"                //贷款周期
        static let client_phone = "client_phone"                            //客户电话
        static let client_occupation = "client_occupation"                  //职业类型
        static let client_occupation_name = "client_occupation_name"        //职业名称
        static let client_other_assets = "client_other_assets"              //其他资产
    
    }
    
    public var client_id: Int = 0
    public var client_name: String = ""
    public var client_type: Int = 0
    public var client_mortgage_asset: Int = 0
    public var client_loan_need: Int = 0
    public var client_house_type: Int = 0
    public var client_car_type: Int = 0
    public var client_month_income: Int = 0
    public var client_income_payment_type: Int = 0
    public var client_is_shenzhen_census: ServiceBool = .serviceFalse
    public var client_is_accumulated_funds: ServiceBool = .serviceFalse
    public var client_is_social_security: ServiceBool = .serviceFalse
    public var client_price: Int = 0
    public var client_days_need: Int = 0
    public var client_loan_period: Int = 0
    public var client_phone: String = ""
    public var client_occupation: String = ""
    
    public var client_type_name: String = ""
    public var client_house_type_name: String = ""
    public var client_car_type_name: String = ""
    public var client_occupation_name: String = ""
    public var client_income_payment_type_name: String = ""
    public var client_other_assets: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.client_id = appInfo[Keys.client_id].intValue
        self.client_name = appInfo[Keys.client_name].stringValue
        self.client_type = appInfo[Keys.client_type].intValue
        self.client_mortgage_asset = appInfo[Keys.client_mortgage_asset].intValue
        self.client_loan_need = appInfo[Keys.client_loan_need].intValue
        self.client_house_type = appInfo[Keys.client_house_type].intValue
        self.client_car_type = appInfo[Keys.client_car_type].intValue
        self.client_month_income = appInfo[Keys.client_month_income].intValue
        self.client_income_payment_type = appInfo[Keys.client_income_payment_type].intValue
        self.client_is_shenzhen_census = ServiceBool(with: appInfo[Keys.client_is_shenzhen_census].intValue)
        self.client_is_accumulated_funds = ServiceBool(with: appInfo[Keys.client_is_accumulated_funds].intValue)
        self.client_is_social_security = ServiceBool(with: appInfo[Keys.client_is_social_security].intValue)
        self.client_price = appInfo[Keys.client_price].intValue
        self.client_days_need = appInfo[Keys.client_days_need].intValue
        self.client_loan_period = appInfo[Keys.client_loan_period].intValue
        self.client_phone = appInfo[Keys.client_phone].stringValue
        self.client_occupation = appInfo[Keys.client_occupation].stringValue
        self.client_type_name = appInfo[Keys.client_type_name].stringValue
        self.client_house_type_name = appInfo[Keys.client_house_type_name].stringValue
        self.client_car_type_name = appInfo[Keys.client_car_type_name].stringValue
        self.client_occupation_name = appInfo[Keys.client_occupation_name].stringValue
        self.client_income_payment_type_name = appInfo[Keys.client_income_payment_type_name].stringValue
        self.client_other_assets = appInfo[Keys.client_other_assets].stringValue
    }
    
    override init() {
        super .init()
    }
}

extension ClientInfoModel {
    func getTypeImage() -> UIImage {
        switch client_type {
        case 1:
            return #imageLiteral(resourceName: "ICON-jinzhunkehu")
        case 2:
            return #imageLiteral(resourceName: "ICON-youzhikehu")
        default:
            return UIImage()
        }
    }
    
    func getClientType() -> String {
        switch client_type {
        case 1:
            return "精准客户"
        case 2:
            return "优质客户"
        default:
            return ""
        }
    }
    
    func getIncomePayType() ->String {
        switch client_income_payment_type {
        case 1:
            return "银行代发"
        case 2:
            return "现金发放"
        default:
            return ""
        }
    }
    
    func getpledgeType() ->String {
        switch client_mortgage_asset {
        case 1:
            return "房屋抵押"
        case 2:
            return "车辆抵押"
        default:
            return ""
        }
    }
    
    func getHouseInfo() ->String {
        switch client_house_type {
        case 1:
            return "无房"
        case 2:
            return "有贷款房"
        case 3:
            return "有红本房"
        case 4:
            return "有小产权房"
        default:
            return ""
        }
    }
    
    func getCarInfo() ->String {
        switch client_car_type {
        case 1:
            return "无车"
        case 2:
            return "有全款车"
        case 3:
            return "有贷款车"
        default:
            return ""
        }
    }
}
