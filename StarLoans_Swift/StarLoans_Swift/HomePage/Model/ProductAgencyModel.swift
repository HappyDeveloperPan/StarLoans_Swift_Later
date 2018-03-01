//
//  ProductAgency.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/23.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//Data.id    Int    贷款产品id号
//Data. product    String    产品名称
//Data . card    String    贷款所属类别([个人信用类],[个人抵押类],[企业信用类],[企业抵押类])
//data. cooperation_bank    string    合作银行
//Data. fast_loan    int    是否是极速审核产品(1:不是极速审核产品 2:是极速审核产品 )
//Data. quota    String    最高额度（万元）
//Data .return_Commission    varchar    返佣
//Data . Claim_amount    varchar    领取金额
//Data . Leader_number    int    已领人数

class ProductAgencyModel: NSObject {
    struct Keys {
        static let product = "product"
        static let quota = "quota"
        static let producttype = "producttype"
        static let return_commission = "return_commission"
        static let claim_amount = "claim_amount"
        static let leader_number = "leader_number"
        static let card = "card"
        static let cooperation_bank = "cooperation_bank"
        static let fast_loan = "fast_loan"
    }
    
    public var product: String = ""
    public var quota: String = ""
    public var producttype: String = ""
    public var return_commission: String = ""
    public var claim_amount: Float = 0
    public var leader_number: Int = 0
    public var card: String = ""
    public var cooperation_bank: String = ""
    public var fast_loan: ServiceBool = .serviceFalse
    
    public init(with json:JSON) {
        let appInfo = json
        self.product = appInfo[Keys.product].stringValue
        self.quota = appInfo[Keys.quota].stringValue
        self.producttype = appInfo[Keys.producttype].stringValue
        self.return_commission = appInfo[Keys.return_commission].stringValue
        self.claim_amount = appInfo[Keys.claim_amount].floatValue
        self.leader_number = appInfo[Keys.leader_number].intValue
        self.card = appInfo[Keys.card].stringValue
        self.cooperation_bank = appInfo[Keys.cooperation_bank].stringValue
        self.fast_loan = ServiceBool(with: appInfo[Keys.fast_loan].intValue)
    }
    
    override init() {
        super .init()
    }
}
