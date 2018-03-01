//
//  File.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/19.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import Foundation

///  服务器地址
///  线上服务器
public let hostAdress = "http://120.78.171.83/index.php?s="
///  线上图片地址头
public let picAdress = "http://120.78.171.83"
///  魏兄服务器
//public let hostAdress = "http://192.168.2.15/index.php?s="
///  娟姐服务器
//public let hostAdress = "http://192.168.2.19/index.php?s="

//MARK: - 登录接口
///  用户登录
public let kUrl_Login = hostAdress + "/Home/MobileIndex/mobile_ajax_login_ag"
///  自动登录
public let kUrl_AutoLogin = hostAdress + "/Home/MobileIndex/fase_login"
///  获取验证码
public let kUrl_GetCode = hostAdress + "/Home/MobileIndex/mobile_yzms"
///  用户注册
public let kUrl_Register = hostAdress + "/Home/MobileIndex/mobile_ajax_reg_ag"
///  忘记密码
public let kUrl_ForgetPWD = hostAdress + "/Home/MobileIndex/mobile_ajax_ag_fg"

//MARK: - 首页接口
///  首页广告图
public let kUrl_HomePageTopBanner = hostAdress + "/Home/MobileAppBanner/index"
///  热门视频
public let kUrl_HotVideo = hostAdress + "/Home/MobileVideo/videoHot"
///  热门产品
public let kUrl_HotProduct = hostAdress + "/Home/MobileHotProduct/three"
///  底部广告图
public let kUrl_BottomBanner = hostAdress + "/Home/mobileFooterAdvertisement/footer_advertisement_image"
///  热门抢单
public let kUrl_HotQuickRob = hostAdress + "/Home/MobileQuickBill/Billhot"
///  活动中心
//public let kUrl_ActivityCenter = hostAdress + "/Home/MobileActivity/centerActivityImg"
public let kUrl_ActivityCenterDetail = hostAdress + "/Home/MobileActivity/centerActivityDetailPage"
public let kUrl_ActivityCenter = hostAdress + "/Home/MobileCommon/centerIndexImgs"

///  行业资源
public let kUrl_IndustryResources = hostAdress + "/Home/MobileIndustryResources/index"
///  贷款学院
public let kUrl_LoanCollege = hostAdress + "/Home/MobileLoanCollege/index"
///  推广工具
public let kUrl_PopularizeTool = hostAdress + ""
///  获取用户签到
public let kUrl_GetSignInfo = hostAdress + "/Home/MobileSign/index"
///  用户签到
public let kUrl_UserSignIn = hostAdress + "/Home/MobileSign/point"
///  资讯研读
public let kUrl_InfoStudying = hostAdress + "/Home/MobileInformationStudy/index"
///  视频中心
public let kUrl_VideoCenter = hostAdress + "Home/MobileVideo/videoList"
///  视频详情
public let kUrl_VideoDetail = hostAdress + "/Home/MobileVideo/videoInfo"

//MARK: - 急速抢单
///  抢单客户信息列表
public let kUrl_QuickBillList = hostAdress + "/Home/MobileQuickBill/billList"
///  抢单客户信息详情
public let kUrl_QuickBillDetail = hostAdress + "/Home/MobileQuickBill/billInfo"
///  获取推送设置
public let kUrl_GetQuickBillPushSetting = hostAdress + "/Home/MobileQuickBill/pushSettingsInfo"
///  修改推送设置
public let kUrl_QuickBillPushSetting = hostAdress + "/Home/MobileQuickBill/pushSettings"

//MARK: - 贷款接口
///贷款产品列表
public let kUrl_LoansProductList = hostAdress + "/Home/MobileLoanProducts/three"
///贷款产品详情
public let kUrl_LoansProductDetail = hostAdress + "/Home/MobileLoanProducts/detail"
///问题列表接口
public let kUrl_ProductQuestionList = hostAdress + "/Home/MobileProductQuestion/productQuestionList"
///提问接口
public let kUrl_QuestionAsk = hostAdress + "/Home/MobileProductQuestion/productQuestion"
///回答问题
public let kUrl_QuestionAnswer = hostAdress + "/Home/MobileProductQuestion/productAnswer"
///自营产品信息录入
public let kUrl_SelfSupportInput = hostAdress + "/Home/MobileHotProduct/self_entry_customer_information"
///第三方产品录入
public let kUrl_ThirdSupportInput = hostAdress + "/Home/MobileLoanProducts/Economicman_input_Customer_information"
///获取下拉框数据
public let kUrl_ComboBox = hostAdress + "/Home/MobileCommon/commonConfig"

//MARK: - 推单
///急速推单产品列表
public let kUrl_PublishProductList = hostAdress + "/Home/MobileLoanProducts/pushProductList"
///发布客户资源
public let kUrl_PublishClientResources = hostAdress + "/Home/MobileSinglePush/publishing_customer_resources"
///发布产品资源
public let kUrl_PublishProductResources = hostAdress + "/Home/MobileSinglePush/publishing_product_resources"

//MARK: - 消息接口
///消息列表接口
public let kUrl_InfoList = hostAdress + "/Home/MobileMessage/messageList"
///消息详情接口
public let kUrl_InfoDetail = hostAdress + "/Home/MobileMessage/messageInfo"
///删除消息
public let kUrl_removeInfo = hostAdress + "/Home/MobileMessage/messageInvalid"

//MARK: - 个人中心
///个人信息获取
public let kUrl_UserData = hostAdress + "/Home/MobileCenter/centerInfo"

///修改头像
public let kUrl_ModifyHeadImg = hostAdress + "/Home/MobileCenter/centerImgChange"
///手机号码修改
public let kUrl_ChangePhone = hostAdress + "/Home/MobileCenter/centerPhoneChange"
///设置交易密码
public let kUrl_SetDealPWD = hostAdress + "/Home/MobileCenter/centerExchangePwd"
///修改登录密码
public let kUrl_ResetLoginPass = hostAdress + "/Home/MobileCenter/centerLoginPwdReset"
///意见反馈
public let kUrl_OpinionFeedback = hostAdress + "/Home/MobileCenter/centerFeedbackQuestion"
///常见问题列表
public let kUrl_QuestionList = hostAdress + "/Home/MobileQuestions/questionList"
///常见问题答案
public let kUrl_QuestionInfo = hostAdress + "/Home/MobileQuestions/questionInfo"

///交易明细
public let kUrl_DealRecord = hostAdress + "/Home/MobileCenter/centerExchangeInfo"
///银行卡列表
public let kUrl_BankCardList = hostAdress + "/Home/MobileBankCard/centerBankCardList"
///获取银行卡信息
public let kUrl_BankCardInfo = hostAdress + "/Home/MobileBankCard/centerBankInfo"
///银行卡添加
public let kUrl_BankCardAdd = hostAdress + "/Home/MobileBankCard/centerBankCardAdd"
///银行卡删除
public let kUrl_BankCardRemove = hostAdress + "/Home/MobileBankCard/centerBankCardInvalid"
///提现
public let kUrl_Withdraw = hostAdress + "/Home/MobileWxWithdrawals/index"

///添加认证
public let kUrl_AddApprove = hostAdress + "/Home/MobileCenter/centerAuthInfo"
///所属门店
public let kUrl_ApproveStore = hostAdress + "/Home/MobileCenter/centerBelongStore"

///客户经理个人首页
public let kUrl_ManagerHomePage = hostAdress + "/Home/MobileOrder/managerOrderTotal"
///客户经理微店订单列表
public let kUrl_ManagerOrderList = hostAdress + "/Home/MobileOrder/managerOrderList"
///微店订单受理
public let kUrl_ManagerOrderHandle = hostAdress + "/Home/MobileOrder/managerOrderHandle"
///微店初审通过
public let kUrl_ManagerOrderFeedback = hostAdress + "/Home/MobileOrder/managerOrderFeedback"
///微店提交资料
public let kUrl_ManagerOrderFurtherInfo = hostAdress + "/Home/MobileOrder/managerOrderFurtherInfo"
///微店审批通过
public let kUrl_ManagerOrderPass = hostAdress + "/Home/MobileOrder/managerOrderPass"
///微店审批不通过
public let kUrl_ManagerOrderNoPass = hostAdress + "/Home/MobileOrder/managerOrderNoPass"
///微店抵押
public let kUrl_ManagerOrderMortgage = hostAdress + "/Home/MobileOrder/managerOrderMortgage"
///微店放款
public let kUrl_ManagerOrderLending = hostAdress + "/Home/MobileOrder/managerOrderLending"

///经纪人微店订单列表
public let kUrl_BrokerOrderList = hostAdress + "/Home/MobileOrder/orderList"

//MARK: - 支付接口
///调取微信支付
public let kUrl_WeChatPay = hostAdress + "/Home/MobileWxPreorder/index"
///完成支付回调
public let kUrl_PayCallback = hostAdress + "/Home/MobileWxPayResult/index"

//MARK: - 聚合数据
///银行卡真伪
public let kUrl_BankCardVerify = "http://detectionBankCard.api.juhe.cn/bankCard"
///银行卡四元素
public let kUrl_FourElementsVerify = "http://v.juhe.cn/verifybankcard4/query"
///热点新闻
public let kUrl_HotNews = "http://v.juhe.cn/toutiao/index"



