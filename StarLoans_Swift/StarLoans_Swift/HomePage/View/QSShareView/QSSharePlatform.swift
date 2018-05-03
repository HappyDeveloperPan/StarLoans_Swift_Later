//
//  QSSharePlatform.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/11.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

enum QSShareType: Int {
    case QSShareTypeWechatSession = 1           //微信好友
    case QSShareTypeWechatTimeline = 2          //微信朋友圈
    case QSShareTypeQQ = 3                      //QQ好友
}

enum QSShareContentType: Int {
    case QSShareContentTypeText = 1             //文本分享
    case QSShareContentTypeImage = 2            //图片分享
    case QSShareContentTypeLink = 3             //链接分享
}

/// 分享平台Model
class QSSharePlatform: NSObject {
    var iconStateNormal: String = ""
    var iconStateHighlighted: String = ""
    var name: String = ""
    var shareType: QSShareType?
}

/// 分享平台的协议
protocol LinkPlatformProtocol {
    func shareLinkToPlatform(_ shareModel: QSShareModel, shareType: QSShareType, shareContentType: QSShareContentType)
}

// MARK: - 分享平台的协议, 并且指定该协议只可以被QSShareView继承
extension LinkPlatformProtocol where Self: QSShareView {
    
    /// 根据自己的分享平台分享内容
    ///
    /// - Parameters:
    ///   - shareModel: 分享平台所需数据类型(比如标题, 图片, 网址...)
    ///   - shareType: 分享的平台
    ///   - shareContentType: 分享的内容类型(文本, 富文本, 网址, APP内容...)
    func shareLinkToPlatform(_ shareModel: QSShareModel, shareType: QSShareType, shareContentType: QSShareContentType) {
        switch shareType {
        case .QSShareTypeWechatSession:
            sendMessageToWX(shareModel, bText: false, scene: WXSceneSession)
            break
        case .QSShareTypeWechatTimeline:
            sendMessageToWX(shareModel, bText: false, scene: WXSceneTimeline)
            break
        default:break
        }
    }
    
    /// 分享到微信(这里使用的是微信原生的分享,根据自己需求编写)
    ///
    /// - Parameters:
    ///   - shareModel: 分享平台所需数据类型(比如标题, 图片, 网址...)
    ///   - bText: 微信字段(是否为富文本)
    ///   - scene: 微信分享类别
    func sendMessageToWX(_ shareModel: QSShareModel, bText: Bool, scene: WXScene) {
        let message = WXMediaMessage()
        message.title = shareModel.title
        message.description = shareModel.descr
        message.setThumbImage(UIImage(named: shareModel.image))
        
        let webPageObject = WXWebpageObject()
        webPageObject.webpageUrl = shareModel.url
        message.mediaObject = webPageObject
        
        let req = SendMessageToWXReq()
        req.bText = bText
        req.message = message
        req.scene = Int32(scene.rawValue)
        
        WXApi.send(req)
    }
}
