//
//  LoansCollegeModel.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/21.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

//Data.id    int    id
//Data.type    int    1:技能培训  2：产口介绍   3：职业培训
//Data. image_video    String    图片或视频（视频以后可能会上）
//Data. title    String    标题
//Data. reading_number    int    阅读数
//Data. date_time    timestamp    日期

class LoansCollegeModel: NSObject {
    struct Keys {
        static let id = "id"
        static let type = "type"
        static let image_video = "image_video"
        static let title = "title"
        static let reading_number = "reading_number"
        static let date_time = "date_time"
    }
    
    public var id: Int = 0
    public var type: Int = 0
    public var image_video: String = ""
    public var title: String = ""
    public var reading_number: Int = 0
    public var date_time: String = ""
    
    public init(with json:JSON) {
        let appInfo = json
        self.id = appInfo[Keys.id].intValue
        self.type = appInfo[Keys.type].intValue
        self.image_video = appInfo[Keys.image_video].stringValue
        self.title = appInfo[Keys.title].stringValue
        self.reading_number = appInfo[Keys.reading_number].intValue
        self.date_time = appInfo[Keys.date_time].stringValue
    }
    
    override init() {
        super .init()
    }
}
