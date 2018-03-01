//
//  QuestionModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/13.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuestionModel: NSObject {
    struct Keys {
        static let question_time = "question_time"      //提问时间
        static let question_title = "question_title"    //提问问题
        static let answer_content = "answer_content"    //回答内容
        static let answer_id = "answer_id"              //回答者id
        static let answer_user = "answer_user"          //回答者昵称
        static let questioner_id = "questioner_id"      //提问者id
        static let questioner_tx = "questioner_tx"      //提问者头像
        static let questioner_xm = "questioner_xm"      //提问者姓名
        static let questioner_user = "questioner_user"  //提问者昵称
    }
    
    public var question_time: Double = 0
    public var question_title: String = ""
    public var answer_content: String = ""
    public var answer_id: Int = 0
    public var answer_user: String = ""
    public var questioner_id: Int = 0
    public var questioner_tx: String = ""
    public var questioner_xm: String = ""
    public var questioner_user: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.question_time = appInfo[Keys.question_time].doubleValue
        self.question_title = appInfo[Keys.question_title].stringValue
        self.answer_content = appInfo[Keys.answer_content].stringValue
        self.answer_id = appInfo[Keys.answer_id].intValue
        self.answer_user = appInfo[Keys.answer_user].stringValue
        self.questioner_id = appInfo[Keys.questioner_id].intValue
        self.questioner_tx = appInfo[Keys.questioner_tx].stringValue
        self.questioner_xm = appInfo[Keys.questioner_xm].stringValue
        self.questioner_user = appInfo[Keys.questioner_user].stringValue
    }
    
    override init() {
        super .init()
    }
}
