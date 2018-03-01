//
//  UserModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/24.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserModel: NSObject {
    
    struct Keys {
        static let id = "id"
        static let phoneNumber = "phoneNumber"
        static let password = "password"
        static let token = "token"
        static let yzm = "yzm"
        static let user = "user"                                //用户名
        static let tx = "tx"                                    //头像
        static let is_audit = "is_audit"                        //是否认证经纪人，1未认证2审核中3认证不成功4认证成功
        static let is_audit_name = "is_audit_name"              //是否认证经纪人值
        static let type = "type"                                //用户类型，1第三方经纪人，2机构经理，3平台信贷经理
        static let lng = "lng"                                  //维度
        static let lat = "lat"                                  //经度
        static let xm = "xm"                                    //姓名
        static let name = "name"                                //姓名
        static let phone = "phone"                              //电话号码
        static let account = "account"                          //账户
        static let wd_push_order = "wd_push_order"              //已推订单
        static let wd_publish_resource = "wd_publish_resource"  //已发资源
        static let wd_publish_product = "wd_publish_product"    //已发产品
        static let wd_quick_bill = "wd_quick_bill"              //急速抢单
        static let buy_video = "buy_video"                      //已购视频
        static let buy_tools = "buy_tools"                      //已购工具
        static let buy_list = "buy_list"                        //已购客户名单
        static let buy_course = "buy_course"                    //已购教程
        static let bank = "bank"                                //银行卡
        static let card_type = "card_type"                      //银行卡类型
        static let card_no = "card_no"                          //银行卡号
        static let logo_small = "logo_small"                    //银行卡小图
        static let name_short = "name_short"                    //银行卡简称
        static let bank_code = "bank_code"                      //开卡银行代号
        static let bank_full = "bank_full"                      //开卡银行全称
        static let bank_short = "bank_short"                    //开卡银行简称
        static let last_four = "last_four"                      //银行卡后四位
        static let logo_big = "logo_big"                        //开卡银行logo
        static let card_id = "card_id"                          //银行卡id
        static let location = "location"                        //定位城市
        static let is_exchange_pwd = "is_exchange_pwd"          //是否设置交易密码
        static let question_id = "question_id"                  //问题id
        static let question = "question"                        //问题标题
        static let answer = "answer"                            //回答问题
        static let waitHandle = "waitHandle"                    //待受理
        static let waitFeedback = "waitFeedback"                //待反馈
        static let waitApprove = "waitApprove"                  //待审批
        static let waitMortgage = "waitMortgage"                //待抵押
        static let waitPay = "waitPay"                          //待放款
        static let noPass = "noPass"                            //未通过
        static let finish = "finish"                            //已完成
    }
    
    public var id: Int = 0
    public var phoneNumber: String = ""
    public var password: String = ""
    public var token: String = ""
    public var yzm: String = ""
    public var user: String = ""
    public var tx: String = ""
    public var is_audit: Int = 0
    public var is_audit_name: String = ""
    public var type: Int = 0
    public var lng: Double = 0
    public var lat: Double = 0
    public var xm: String = ""
    public var name: String = ""
    public var phone: String = ""
    public var account: Float = 0
    public var wd_push_order: Int = 0
    public var wd_publish_resource: Int = 0
    public var wd_publish_product: Int = 0
    public var wd_quick_bill: Int = 0
    public var buy_video: Int = 0
    public var buy_tools: Int = 0
    public var buy_list: Int = 0
    public var buy_course: Int = 0
    public var bank: String = ""
    public var card_type: String = ""
    public var card_no: String = ""
    public var logo_small: String = ""
    public var name_short: String = ""
    public var bank_code: String = ""
    public var bank_full: String = ""
    public var bank_short: String = ""
    public var last_four: String = ""
    public var logo_big: String = ""
    public var card_id: Int = 0
    public var location: String = ""
    public var is_exchange_pwd: Bool = false
    public var question_id: Int = 0
    public var question: String = ""
    public var answer: String = ""
    public var waitHandle: Int = 0
    public var waitFeedback: Int = 0
    public var waitApprove: Int = 0
    public var waitMortgage: Int = 0
    public var waitPay: Int = 0
    public var noPass: Int = 0
    public var finish: Int = 0
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.phoneNumber = appInfo[Keys.phoneNumber].stringValue
        self.password = appInfo[Keys.password].stringValue
        self.token = appInfo[Keys.token].stringValue
        self.yzm = appInfo[Keys.yzm].stringValue
        self.user = appInfo[Keys.user].stringValue
        self.tx = appInfo[Keys.tx].stringValue
        self.is_audit = appInfo[Keys.is_audit].intValue
        self.is_audit_name = appInfo[Keys.is_audit_name].stringValue
        self.type = appInfo[Keys.type].intValue
        self.lng = appInfo[Keys.lng].doubleValue
        self.lat = appInfo[Keys.lat].doubleValue
        self.xm = appInfo[Keys.xm].stringValue
        self.name = appInfo[Keys.name].stringValue
        self.phone = appInfo[Keys.phone].stringValue
        self.account = appInfo[Keys.account].floatValue
        self.wd_push_order = appInfo[Keys.wd_push_order].intValue
        self.wd_publish_resource = appInfo[Keys.wd_publish_resource].intValue
        self.wd_publish_product = appInfo[Keys.wd_publish_product].intValue
        self.wd_quick_bill = appInfo[Keys.wd_quick_bill].intValue
        self.buy_video = appInfo[Keys.buy_video].intValue
        self.buy_tools = appInfo[Keys.buy_tools].intValue
        self.buy_list = appInfo[Keys.buy_list].intValue
        self.buy_course = appInfo[Keys.buy_course].intValue
        self.bank = appInfo[Keys.bank].stringValue
        self.card_type = appInfo[Keys.card_type].stringValue
        self.card_no = appInfo[Keys.card_no].stringValue
        self.logo_small = appInfo[Keys.logo_small].stringValue
        self.name_short = appInfo[Keys.name_short].stringValue
        self.bank_code = appInfo[Keys.bank_code].stringValue
        self.bank_full = appInfo[Keys.bank_full].stringValue
        self.bank_short = appInfo[Keys.bank_short].stringValue
        self.last_four = appInfo[Keys.last_four].stringValue
        self.logo_big = appInfo[Keys.logo_big].stringValue
        self.card_id = appInfo[Keys.card_id].intValue
        self.location = appInfo[Keys.location].stringValue
        self.is_exchange_pwd = appInfo[Keys.is_exchange_pwd].boolValue
        self.question_id = appInfo[Keys.question_id].intValue
        self.question = appInfo[Keys.question].stringValue
        self.answer = appInfo[Keys.answer].stringValue
        self.waitHandle = appInfo[Keys.waitHandle].intValue
        self.waitFeedback = appInfo[Keys.waitFeedback].intValue
        self.waitApprove = appInfo[Keys.waitApprove].intValue
        self.waitMortgage = appInfo[Keys.waitMortgage].intValue
        self.waitPay = appInfo[Keys.waitPay].intValue
        self.noPass = appInfo[Keys.noPass].intValue
        self.finish = appInfo[Keys.finish].intValue
    }

    override init() {
        super .init()
    }
    
    func getAuditStatus() -> String {
        switch is_audit {
        case 1:
            return "未认证"
        case 2:
            return "审核中"
//        case 3:
//            return "认证失败"
//        case 4:
//            return "认证成功"
        default:
            return "未认证"
        }
    }
    
    func getApproveType() ->String {
        switch type {
        case 1:
            return "经纪人"
        case 2:
            return "机构经理"
        case 3:
            return "信贷经理"
        default:
            return "未认证"
        }
    }
    
}
