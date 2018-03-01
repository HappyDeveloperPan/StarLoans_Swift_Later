//
//  PayModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/10.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON
//        * 请求类型
//        @property (nonatomic, assign) int type;
//        * 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录
//        @property (nonatomic, retain) NSString* openID;
//        /** 商家向财付通申请的商家id,在注册的时候给的 */
//        @property (nonatomic, retain) NSString *partnerId;
//        /** 预支付订单,这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你 */
//        @property (nonatomic, retain) NSString *prepayId;
//        /** 随机串，防重发,在后台生成 */
//        @property (nonatomic, retain) NSString *nonceStr;
//        /** 时间戳，防重发,也是在后台生成的，为了验证支付的 */
//        @property (nonatomic, assign) UInt32 timeStamp;
//        /** 商家根据财付通文档填写的数据和签名,这个比较特殊，是固定的，只能是即req.package = Sign=WXPay */
//        @property (nonatomic, retain) NSString *package;
//        /** 商家根据微信开放平台文档对数据做的签名,这个签名也是后台做的 */
//        @property (nonatomic, retain) NSString *sign;

class PayModel: NSObject {
    struct Keys {
        static let type = "type"
        static let appid = "appid"
        static let openID = "openID"
        static let partnerid = "partnerid"
        static let prepayid = "prepayid"
        static let noncestr = "noncestr"
        static let timestamp = "timestamp"
        static let package = "package"
        static let sign = "sign"
    }
    
    public var type: Int = 0
    public var appid: String = ""
    public var openID: String = ""
    public var partnerid: String = ""
    public var prepayid: String = ""
    public var noncestr: String = ""
    public var timestamp: UInt32 = 0
    public var package: String = ""
    public var sign: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.type = appInfo[Keys.type].intValue
        self.appid = appInfo[Keys.appid].stringValue
        self.openID = appInfo[Keys.openID].stringValue
        self.partnerid = appInfo[Keys.partnerid].stringValue
        self.prepayid = appInfo[Keys.prepayid].stringValue
        self.noncestr = appInfo[Keys.noncestr].stringValue
        self.timestamp = appInfo[Keys.timestamp].uInt32Value
        self.package = appInfo[Keys.package].stringValue
        self.sign = appInfo[Keys.sign].stringValue
    }
    
    override init() {
        super .init()
    }
}
