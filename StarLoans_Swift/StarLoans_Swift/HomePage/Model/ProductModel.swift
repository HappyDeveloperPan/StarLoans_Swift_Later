//
//  ProductModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/31.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//Data.id    int    贷款产品表id
//Data. card    String    所属类别([个人类],[企业类])
//Data. type    string    类(例：[信用类]，[抵押类]，[有房产，周转，创业，结婚，旅游类])
//Data. product    string    产品名称
//Data. cooperation_bank    string    合作银行
//Data. label    string    要求标签(例:无需抵押物)
//Data. lend_term    Int    放款时间（天）
//Data. quota    string    最高额度（万元）
//Data. return_commission    string    返佣
//Data. claim_amount    string    领取金额
//Data. leader_number    int    已领人数


class ProductModel: NSObject {
    struct Keys {
        static let id = "id"
        static let product = "product"
        static let product_id = "product_id"
        static let quota = "quota"                          //贷款金额
        static let type = "type"
        static let return_commission = "return_commission"  //返佣
        static let claim_amount = "claim_amount"
        static let leader_number = "leader_number"          //已领人数
        static let card = "card"                            //抵押id
        static let card_name = "card_name"                  //抵押类型
        static let cooperation_bank = "cooperation_bank"    //合作银行
        static let fast_loan = "fast_loan"
        static let label = "label"                          //要求标签(例:无需抵押物)
        static let lend_term = "lend_term"                  //放款时间
        
        static let interest = "interest"                    //月息
        static let min_term = "min_term"                    //贷款期限
        static let add_time = "add_time"                    //添加时间
        static let small_img = "small_img"                  //缩略图
        static let img = "img"                              //产品图片
        static let logo = "logo"                            //公司logo
        static let position = "position"                    //推荐人
        static let interest_type = "interest_type"          //利息类型
        static let max_term = "max_term"                    //最大贷款期限
        static let tag = "tag"                              //展示标签（展示是HOT NEW或是独家）
        static let way = "way"                              //还款方式
        static let desc = "desc"                            //产品优势
        static let producttype = "producttype"              //真正产品类型
        static let require = "require"                      //申请条件
        static let info = "info"                            //所需材料
        static let seo_title = "seo_title"                  //优化标题
        static let seo_keyword = "seo_keyword"              //优化关键字
        static let seo_description = "seo_description"      //优化描述
        static let hyid = "hyid"                            //第三方顾问ID,0代表不是第三方顾问
        static let sh = "sh"                                //管理员审核
        static let num = "num"                              //查看次数
        static let product_question = "product_question"    //问题讨论(数组)
        static let url = "url"                              //跳转网址
    }
    
    public var id: Int = 0
    public var product: String = ""
    public var product_id: Int = 0
    public var quota: String = ""
    public var type: String = ""
    public var return_commission: Float = 0
    public var claim_amount: Float = 0
    public var leader_number: Int = 0
    public var card: Int = 0
    public var card_name: String = ""
    public var cooperation_bank: String = ""
    public var fast_loan: ServiceBool = .serviceFalse
    public var label: String = ""
    public var lend_term: Int = 0
    
    public var interest: String = ""
    public var min_term: Int = 0
    public var add_time: Int = 0
    public var small_img: String = ""
    public var img: String = ""
    public var logo: String = ""
    public var position: String = ""
    public var interest_type: String = ""
    public var max_term: Int = 0
    public var tag: String = ""
    public var way: String = ""
    public var desc: String = ""
    public var producttype: String = ""
    public var require: String = ""
    public var info: String = ""
    public var seo_title: String = ""
    public var seo_keyword: String = ""
    public var seo_description: String = ""
    public var hyid: Int = 0
    public var sh: Int = 0
    public var num: Int = 0
    public var url: String = ""
    public var product_question: Array = [JSON]()
    
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.product = appInfo[Keys.product].stringValue
        self.product_id = appInfo[Keys.product_id].intValue
        self.quota = appInfo[Keys.quota].stringValue
        self.type = appInfo[Keys.type].stringValue
        self.return_commission = appInfo[Keys.return_commission].floatValue
        self.claim_amount = appInfo[Keys.claim_amount].floatValue
        self.leader_number = appInfo[Keys.leader_number].intValue
        self.card = appInfo[Keys.card].intValue
        self.card_name = appInfo[Keys.card_name].stringValue
        self.cooperation_bank = appInfo[Keys.cooperation_bank].stringValue
        self.fast_loan = ServiceBool(with: appInfo[Keys.fast_loan].intValue)
        self.label = appInfo[Keys.label].stringValue
        self.lend_term = appInfo[Keys.lend_term].intValue
        
        self.interest = appInfo[Keys.interest].stringValue
        self.min_term = appInfo[Keys.min_term].intValue
        self.add_time = appInfo[Keys.add_time].intValue
        self.small_img = appInfo[Keys.small_img].stringValue
        self.img = appInfo[Keys.img].stringValue
        self.logo = appInfo[Keys.logo].stringValue
        self.position = appInfo[Keys.position].stringValue
        self.interest_type = appInfo[Keys.interest_type].stringValue
        self.max_term = appInfo[Keys.max_term].intValue
        self.tag = appInfo[Keys.tag].stringValue
        self.way = appInfo[Keys.way].stringValue
        self.desc = appInfo[Keys.desc].stringValue
        self.producttype = appInfo[Keys.producttype].stringValue
        self.require = appInfo[Keys.require].stringValue
        self.info = appInfo[Keys.info].stringValue
        self.seo_title = appInfo[Keys.seo_title].stringValue
        self.seo_keyword = appInfo[Keys.seo_keyword].stringValue
        self.seo_description = appInfo[Keys.seo_description].stringValue
        self.hyid = appInfo[Keys.hyid].intValue
        self.sh = appInfo[Keys.sh].intValue
        self.num = appInfo[Keys.num].intValue
        self.url = appInfo[Keys.url].stringValue
        self.product_question = appInfo[Keys.product_question].arrayValue
    }
    
    override init() {
        super .init()
    }
}
