//
//  VideoModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//video_id    int(32)    视频ID
//video_title    string(32)    视频标题
//video_theme    string(255)    视频主题
//video_upload_time    int(32)    视频上传时间
//video_speakers    string(255)    视频主讲嘉宾
//video_sponsor    string(255)    视频主办方
//video_duration    string(32)    视频时长
//video_desc    text    视频描述
//video_price    decimal(10,2)    视频价格
//video_view_count    int(11)    视频观看次数
//video_address    string(255)    视频存放地址
//video_img    string(255)    视频封面图
//video_type    tinyint(3)    视频分类，1热门视频，2产品视频，3路演视频



class VideoModel: NSObject {
    struct Keys {
        static let video_id = "video_id"
        static let video_title = "video_title"
        static let video_desc = "video_desc"
        static let video_theme = "video_theme"
        static let video_price = "video_price"
        static let video_view_count = "video_view_count"
        static let video_address = "video_address"
        static let video_type = "video_type"
        static let video_img = "video_img"
        static let video_upload_time = "video_upload_time"
        static let video_speakers = "video_speakers"
        static let video_sponsor = "video_sponsor"
        static let video_duration = "video_duration"
    }
    
    public var video_id: Int = 0
    public var video_title: String = ""
    public var video_desc: String = ""
    public var video_theme: String = ""
    public var video_price: Int = 0
    public var video_view_count: Int = 0
    public var video_address: String = ""
    public var video_type: Int = 0
    public var video_img: String = ""
    public var video_upload_time: Double = 0
    public var video_speakers: String = ""
    public var video_sponsor: String = ""
    public var video_duration: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.video_id = appInfo[Keys.video_id].intValue
        self.video_title = appInfo[Keys.video_title].stringValue
        self.video_desc = appInfo[Keys.video_desc].stringValue
        self.video_theme = appInfo[Keys.video_theme].stringValue
        self.video_price = appInfo[Keys.video_price].intValue
        self.video_view_count = appInfo[Keys.video_view_count].intValue
        self.video_address = appInfo[Keys.video_address].stringValue
        self.video_type = appInfo[Keys.video_type].intValue
        self.video_img = appInfo[Keys.video_img].stringValue
        self.video_upload_time = appInfo[Keys.video_upload_time].doubleValue
        self.video_speakers = appInfo[Keys.video_speakers].stringValue
        self.video_sponsor = appInfo[Keys.video_sponsor].stringValue
        self.video_duration = appInfo[Keys.video_duration].stringValue
    }
    
    override init() {
        super .init()
    }
}

extension VideoModel {
    func getVideoType() ->String {
        switch video_type {
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
