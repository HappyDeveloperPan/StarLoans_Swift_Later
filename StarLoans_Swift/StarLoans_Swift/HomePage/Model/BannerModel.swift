//
//  BannerModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/23.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON
//Data. id    String    id数据
//Data. banner    String    banner名
//Data.group    String    分组
//Data.image    String    banner图
//Data.url    String    跳转链接
//Data. target    String    是否新窗口
//Data.add_time    int    添加时间

class BannerModel: NSObject {
    struct Keys {
        static let id = "id"
        static let banner = "banner"
        static let group = "group"
        static let image = "image"
        static let url = "url"
        static let target = "target"
        static let add_time = "add_time"
    }
    
    public var id: Int = 0
    public var banner: String = ""
    public var group: String = ""
    public var image: String = ""
    public var url: String = ""
    public var target: String = ""
    public var add_time: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.banner = appInfo[Keys.banner].stringValue
        self.group = appInfo[Keys.group].stringValue
        self.image = appInfo[Keys.image].stringValue
        self.url = appInfo[Keys.url].stringValue
        self.target = appInfo[Keys.target].stringValue
        self.add_time = appInfo[Keys.add_time].stringValue
    }
    
    override init() {
        super .init()
    }
}
