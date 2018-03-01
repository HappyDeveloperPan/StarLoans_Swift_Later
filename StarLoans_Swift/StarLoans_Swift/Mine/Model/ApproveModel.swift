//
//  ApproveModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/11.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApproveModel: NSObject {
    struct Keys {
        static let type = "type"                                     //认证类型，1第三方经纪人2机构经理3平台信贷经理
        static let name = "name"
        static let sex = "sex"
        static let phone = "phone"
        static let cardid = "cardid"                                 //身份证号码
        static let card_front = "card_front"                         //身份证正面
        static let card_backend = "card_backend"                     //身份证反面
        static let company_name = "company_name"                     //公司名称
        static let company_type = "company_type"                     //公司类型
        static let company_address = "company_address"               //公司地址
        static let company_office = "company_office"                 //营业厅名称
        static let company_logo = "company_logo"                     //公司LOGO
        static let workcard_businesscard = "workcard_businesscard"   //工牌和工卡照片
        static let store_id = "store_id"                             //门店id
        static let store_name = "store_name"                         //门店名称
    }
    
    public var type: Int = 0
    public var name: String = ""
    public var sex: Int = 0
    public var phone: String = ""
    public var cardid: String = ""
    public var card_front: String = ""
    public var card_backend: String = ""
    public var company_name: String = ""
    public var company_type: String = ""
    public var company_address: String = ""
    public var company_office: String = ""
    public var company_logo: String = ""
    public var workcard_businesscard: String = ""
    public var store_id: Int = 0
    public var store_name: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.type = appInfo[Keys.type].intValue
        self.name = appInfo[Keys.name].stringValue
        self.sex = appInfo[Keys.sex].intValue
        self.phone = appInfo[Keys.phone].stringValue
        self.cardid = appInfo[Keys.cardid].stringValue
        self.card_front = appInfo[Keys.card_front].stringValue
        self.card_backend = appInfo[Keys.card_backend].stringValue
        self.company_name = appInfo[Keys.company_name].stringValue
        self.company_type = appInfo[Keys.company_type].stringValue
        self.company_address = appInfo[Keys.company_address].stringValue
        self.company_office = appInfo[Keys.company_office].stringValue
        self.company_logo = appInfo[Keys.company_logo].stringValue
        self.workcard_businesscard = appInfo[Keys.workcard_businesscard].stringValue
        self.store_name = appInfo[Keys.store_name].stringValue
        self.store_id = appInfo[Keys.store_id].intValue
    }
    
    override init() {
        super .init()
    }
}
