//
//  HomePageModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/21.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

enum ServiceBool: Int {
    case serviceFalse = 1
    case serviceTrue = 2
}

extension ServiceBool {
    public func getServiceBool() -> Bool{
        return (self == .serviceFalse) ? false : true
    }
    
    public init(with serviceBool: Int?) {
        
        if let myBool = serviceBool {
            switch myBool {
            case 1...2: self.init(rawValue: myBool)!
            default: self.init(rawValue: 1)!
            }
        } else {
            self.init(rawValue: 1)!
        }
    }
}

//Data. id    String    id数据
//Data. banner    String    banner名
//Data.group    String    分组
//Data.image    String    banner图
//Data.url    String    跳转链接
//Data. target    String    是否新窗口
//Data.add_time    int    添加时间

//total_point    int(11)    累计签到积分
//is_sign    tinyint(3)    今天是否签到，0未签到，1已签到
//sign_accumulate_days    tinyint(3)    累计签到天数
//sign_date    int(32)    登录日期

class HomePageModel: NSObject {
    struct Keys {
        //广告/
        static let id = "id"
        static let banner = "banner"
        static let group = "group"
        static let image = "image"
        static let url = "url"
        static let target = "target"
        static let add_time = "add_time"
        //视频
        static let video_id = "video_id"
        static let videoTitle = "video_title"
        static let videoType = "video_type"
        static let video_img = "video_img"
        //签到
        static let user_id = "user_id"
        static let total_point = "total_point"
        static let is_sign = "is_sign"
        static let sign_accumulate_days = "sign_accumulate_days"
        static let sign_date = "sign_date"
        //活动中心
        static let title = "title"   //标题
        static let img = "img"       //图片地址
    }
    
    public var id: Int = 0
    public var banner: String = ""
    public var group: String = ""
    public var image: String = ""
    public var url: String = ""
    public var target: String = ""
    public var add_time: String = ""
    
    public var video_id: Int = 0
    public var videoTitle: String = ""
    public var videoType: Int = 0
    public var video_img: String = ""
    
    public var user_id: Int = 0
    public var total_point: Int = 0
    public var is_sign: Bool = false
    public var sign_accumulate_days: Int = 0
    public var sign_date: String = ""
    public var title: String = ""
    public var img: String = ""
    
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.banner = appInfo[Keys.banner].stringValue
        self.group = appInfo[Keys.group].stringValue
        self.image = appInfo[Keys.image].stringValue
        self.url = appInfo[Keys.url].stringValue
        self.target = appInfo[Keys.target].stringValue
        self.add_time = appInfo[Keys.add_time].stringValue
        
        self.video_id = appInfo[Keys.video_id].intValue
        self.videoTitle = appInfo[Keys.videoTitle].stringValue
        self.videoType = appInfo[Keys.videoType].intValue
        self.video_img = appInfo[Keys.video_img].stringValue
        
        self.user_id = appInfo[Keys.user_id].intValue
        self.total_point = appInfo[Keys.total_point].intValue
        self.is_sign = appInfo[Keys.is_sign].boolValue
        self.sign_accumulate_days = appInfo[Keys.sign_accumulate_days].intValue
        self.sign_date = appInfo[Keys.sign_date].stringValue
        self.title = appInfo[Keys.title].stringValue
        self.img = appInfo[Keys.img].stringValue
    }
    
    override init() {
        super .init()
    }
    
    func getVideoType() -> String {
        switch videoType {
        case 1:
            return "热门视频"
        case 2:
            return "产品视频"
        case 3:
            return "路演视频"
        default:
            return ""
        }
    }
}
