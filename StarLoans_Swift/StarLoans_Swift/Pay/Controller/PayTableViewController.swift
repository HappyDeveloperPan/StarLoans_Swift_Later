//
//  PayTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/10.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

public let kWechatPayResult = "WechatPayResult"

class PayTableViewController: UITableViewController {
    //MARK: - storyboard连线
    @IBOutlet weak var moneyLB: UILabel!
    @IBOutlet weak var countDownLB: UILabel!
    @IBOutlet weak var selectImgOne: UIImageView!
    @IBOutlet weak var selectImgTwo: UIImageView!
    
    //MARK: - 外部属性
    var price: Float = 0
    var goodsId: Int = 0
    //MARK: - 内部属性
    ///支付类型
    fileprivate enum PayType: Int{
        case balance = 0    //余额
        case Wechat = 1     //微信支付
    }
    fileprivate var payType: PayType = .balance
    fileprivate var selectImgArr = [UIImageView]()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kHomeBackColor
        selectImgArr.append(selectImgOne)
        selectImgArr.append(selectImgTwo)
        
        moneyLB.adjustsFontSizeToFitWidth = true
        moneyLB.text = String(price)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WechatPayResult(notif:)), name: NSNotification.Name(rawValue: kWechatPayResult), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        payType = PayTableViewController.PayType(rawValue: indexPath.row)!
        for i in 0...selectImgArr.count - 1 {
            let imageView = selectImgArr[i]
            if indexPath.row == i {
                imageView.image = #imageLiteral(resourceName: "ICON-xuanzhong")
            }else {
                imageView.image = #imageLiteral(resourceName: "ICON-weixuanzhong")
            }
        }
    }
    
    //MARK: - 控件点击事件
    ///支付按钮点击
    @IBAction func payBtnClick(_ sender: AnimatableButton) {
        switch payType {
        case .balance:
            break
        case .Wechat:
            WechatPay()
        }
    }
}

//MARK: - 数据处理
extension PayTableViewController {
    ///调起微信支付
    func WechatPay() {
        
        JSProgress.showBusy()
        
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["id"] = UserManager.shareManager.userModel.id
        parameters["goods_id"] = goodsId
        parameters["appid"] = WXAppID
        parameters["total_fee"] = price
        parameters["goods_type"] = 1
        
        NetWorksManager.requst(with: kUrl_WeChatPay, type: .post, parameters: parameters) { (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"]{
                    let payModel = PayModel(with: data)
                    let req = PayReq()
                    req.openID = payModel.appid
                    req.partnerId = payModel.partnerid
                    req.prepayId = payModel.prepayid
                    req.nonceStr = payModel.noncestr
                    req.timeStamp = payModel.timestamp
                    req.package = payModel.package
                    req.sign = payModel.sign
                    WXApi.send(req)
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    
    ///微信支付成功回调服务器
    @objc func WechatPayResult(notif:NSNotification?) {
//        let notiInfo = notif?.object
        
    }
}
