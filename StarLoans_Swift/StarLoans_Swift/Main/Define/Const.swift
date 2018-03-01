//
//  File.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/8.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SnapKit

///颜色
public let kMainColor = UIColor(red: 242/255, green: 56/255, blue: 61/255, alpha: 1)
public let kTextColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
public let kTitleColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
public let kLineColor = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1)
public let kHomeBackColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)

///主窗口
let kMainWindow  = UIApplication.shared.delegate?.window
///主窗口frame
let kMainScreenFrame = UIScreen.main.bounds
/// 屏幕的宽
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕的高
let kScreenHeight = UIScreen.main.bounds.height

//MARK: - 机型判断
let isiPhoneX: Bool = (kScreenHeight == 812 ? true : false)

/// 导航栏高度
//let kNavHeight = UIApplication.shared.statusBarFrame.size.height + 44
let kNavHeight:CGFloat = (kScreenHeight == 812 ? 88 : 64)
/// 状态栏高度
//let kStatusHeight = UIApplication.shared.statusBarFrame.size.height
let kStatusHeight:CGFloat = (kScreenHeight == 812 ? 44 : 20)
/// idfv
let idfv = UIDevice.current.identifierForVendor?.uuidString
/// 版本号
let versionCode = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/// 系统版本号
let systemVersion = UIDevice.current.systemVersion

//存储字段
let kRunVersion = "runVersion"  //版本号
let kSavedUser = "savedUser" //用户数据
let kRegistrationID = "registrationID" //极光推送registrationID

//MARK: - 微信支付
let WXAppID = "wxcc538ba142746aa1"
let WXAppSecret = "6d4f4cb06e50868587800b4a708987f9"
let WXAPI = "a98a79shdiajsh89qdoisuoiu8u9889w"  ///密钥
//商户号：1496622762

//MARK: - 极光推送
let JPushAppKey = "18d22f26901b457be3c5733b"
let JPushSecret = "4774e04fe0336272c1e18e7e"

//MARK: - 聚合数据
///热点新闻
let NewsAppKey = "3e06f0507a5f920d7c7697a9527fd019"
///银行卡四元素
let FourElementsAppKey = "0f9830bf55386508ce8f778cd3098edf"
///银行卡校验
let BankCardAppKey = "d0c9179c432d3378339d8db011bcea8a"


