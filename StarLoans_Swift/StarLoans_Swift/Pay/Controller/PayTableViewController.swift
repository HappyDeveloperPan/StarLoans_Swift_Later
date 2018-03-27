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
    fileprivate var timer: DispatchSourceTimer?
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        basicConfig()
        
        NotificationCenter.default.addObserver(self, selector: #selector(WechatPayResult(notif:)), name: NSNotification.Name(rawValue: kWechatPayResult), object: nil)
    }
    
    func basicConfig() {
        view.backgroundColor = kHomeBackColor
        selectImgArr.append(selectImgOne)
        selectImgArr.append(selectImgTwo)
        
        moneyLB.adjustsFontSizeToFitWidth = true
        moneyLB.text = String(price)
        
        countDown()
    }
    
    
    /// 支付倒计时
    func countDown() {
        var timeOut = 15 * 60
        //创建去全局队列
        let queue = DispatchQueue.global()
        //在全局队列下创建一个时间源
        timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        //设定循环时间间隔一秒, 并且立即开始
        timer?.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        //时间源触发事件
        timer?.setEventHandler(handler: { [weak self] in
            if timeOut <= 0 {
                self?.timer?.cancel()
                self?.timer = nil
                DispatchQueue.main.async(execute: {
                    self?.countDownLB.text = "00:00"
                })
            }else {
                //计算剩余时间
                timeOut -= 1
                //主队列中刷新UI
                DispatchQueue.main.async(execute: {
                    var min:String = "00"
                    var sec:String = "00"
                    if timeOut/60 < 10 {
                        min = "0" + String(timeOut/60)
                    }else {
                        min = String(timeOut/60)
                    }
                    if timeOut%60 < 10 {
                        sec = "0" + String(timeOut%60)
                    }else {
                        sec = String(timeOut%60)
                    }
                    self?.countDownLB.text = min + ":" + sec
                })
            }
        })
        //启动时间源
        timer?.resume()
    }
    
    deinit {
        timer?.cancel()
        timer = nil
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
            balancePay()
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
    
    ///余额支付
    func balancePay() {
        JSProgress.showBusy()
        
        var paramaters = [String: Any]()
        paramaters["total_fee"] = price
        paramaters["goods_id"] = goodsId
        paramaters["goods_type"] = 1
        paramaters["token"] = UserManager.shareManager.userModel.token
        paramaters["id"] = UserManager.shareManager.userModel.id
        
        NetWorksManager.requst(with: kUrl_BalancePay, type: .post, parameters: paramaters) { (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                
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
