//
//  InfoModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/1.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON
//message_id    int(11)    消息id
//message_type    tinyint(11)    消息类型，1系统消息2交易消息
//message_title    string(32)    标题
//message_desc    string(255)    内容
//message_time    int(32)    发送时间
//message_read    tinyint(3)    是否已读，1未读2已读

class InfoModel: NSObject {
    struct Keys {
        static let message_id = "message_id"
        static let message_type = "message_type"
        static let message_title = "message_title"
        static let message_desc = "message_desc"
        static let message_time = "message_time"
        static let message_read = "message_read"
        
        static let question_time = "question_time"      //提问时间
        static let question_title = "question_title"    //提问问题
        static let answer_content = "answer_content"    //回答内容
        static let answer_id = "answer_id"              //回答者id
        static let answer_user = "answer_user"          //回答者昵称
        static let questioner_id = "questioner_id"      //提问者id
        static let questioner_tx = "questioner_tx"      //提问者头像
        static let questioner_xm = "questioner_xm"      //提问者姓名
        static let questioner_user = "questioner_user"  //提问者昵称
        static let question_id = "question_id"          //提问问题id
        static let product_id = "product_id"            //产品id
    }
    
    public var message_id: Int = 0
    public var message_type: Int = 0
    public var message_title: String = ""
    public var message_desc: String = ""
    public var message_time: Double = 0
    public var message_read: ServiceBool = .serviceFalse
    
    public var question_time: Double = 0
    public var question_title: String = ""
    public var answer_content: String = ""
    public var answer_id: Int = 0
    public var answer_user: String = ""
    public var questioner_id: Int = 0
    public var questioner_tx: String = ""
    public var questioner_xm: String = ""
    public var questioner_user: String = ""
    public var question_id: Int = 0
    public var product_id: Int = 0
    
    public init(with json:JSON) {
        let appInfo = json
        self.message_id = appInfo[Keys.message_id].intValue
        self.message_type = appInfo[Keys.message_type].intValue
        self.message_title = appInfo[Keys.message_title].stringValue
        self.message_desc = appInfo[Keys.message_desc].stringValue
        self.message_time = appInfo[Keys.message_time].doubleValue
        self.message_read = ServiceBool(with: appInfo[Keys.message_read].intValue)
        
        self.question_time = appInfo[Keys.question_time].doubleValue
        self.question_title = appInfo[Keys.question_title].stringValue
        self.answer_content = appInfo[Keys.answer_content].stringValue
        self.answer_id = appInfo[Keys.answer_id].intValue
        self.answer_user = appInfo[Keys.answer_user].stringValue
        self.questioner_id = appInfo[Keys.questioner_id].intValue
        self.questioner_tx = appInfo[Keys.questioner_tx].stringValue
        self.questioner_xm = appInfo[Keys.questioner_xm].stringValue
        self.questioner_user = appInfo[Keys.questioner_user].stringValue
        self.question_id = appInfo[Keys.question_id].intValue
        self.product_id = appInfo[Keys.product_id].intValue
    }
    
    override init() {
        super .init()
    }
}
