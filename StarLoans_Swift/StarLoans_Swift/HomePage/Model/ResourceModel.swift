//
//  ResourceModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/31.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//Data.id    int    id
//Data.type    int    1:表示是推单教学  2：热门资源   3：热门产品
//Data. image_video    String    图片或视频（视频以后可能会上）
//Data. title    String    标题
//Data. reading_number    int    阅读数
//Data. date_time    timestamp    日期

class ResourceModel: NSObject {
    struct Keys {
        static let id = "id"
        //进件教程
        static let type = "type"
        static let image_video = "image_video"
        static let title = "title"                                  //标题
        static let reading_number = "reading_number"                //阅读数
        static let date_time = "date_time"
        static let uniquekey = "uniquekey"                          //确认值
        static let date = "date"                                    //日期
        static let category = "category"                            //分类
        static let author_name = "author_name"                      //作者姓名
        static let url = "url"                                      //文章网址
        static let thumbnail_pic_s = "thumbnail_pic_s"              //小图
        static let thumbnail_pic_s02 = "thumbnail_pic_s02"          //图片1
        static let thumbnail_pic_s03 = "thumbnail_pic_s03"          //图片2
        static let time = "time"                                    //时间
        static let coming_from = "coming_from"                      //来自
    }
    
    public var id: Int = 0
    public var type: Int = 0
    public var image_video: String = ""
    public var title: String = ""
    public var reading_number: Int = 0
    public var date_time: String = ""
    public var uniquekey: String = ""
    public var date: String = ""
    public var category: String = ""
    public var author_name: String = ""
    public var url: String = ""
    public var thumbnail_pic_s: String = ""
    public var thumbnail_pic_s02: String = ""
    public var thumbnail_pic_s03: String = ""
    public var time: String = ""
    public var coming_from: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.type = appInfo[Keys.type].intValue
        self.image_video = appInfo[Keys.image_video].stringValue
        self.title = appInfo[Keys.title].stringValue
        self.reading_number = appInfo[Keys.reading_number].intValue
        self.date_time = appInfo[Keys.date_time].stringValue
        self.uniquekey = appInfo[Keys.uniquekey].stringValue
        self.date = appInfo[Keys.date].stringValue
        self.category = appInfo[Keys.category].stringValue
        self.author_name = appInfo[Keys.author_name].stringValue
        self.url = appInfo[Keys.url].stringValue
        self.thumbnail_pic_s = appInfo[Keys.thumbnail_pic_s].stringValue
        self.thumbnail_pic_s02 = appInfo[Keys.thumbnail_pic_s02].stringValue
        self.thumbnail_pic_s03 = appInfo[Keys.thumbnail_pic_s03].stringValue
        self.time = appInfo[Keys.time].stringValue
        self.coming_from = appInfo[Keys.coming_from].stringValue
    }
    
    override init() {
        super .init()
    }
}
