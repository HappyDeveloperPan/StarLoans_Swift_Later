//
//  WithdrawViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/18.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

///获取银行卡信息
fileprivate let kBankCardInfo = "bankCardInfo"

class WithdrawViewController: UIViewController, StoryboardLoadable {
    //  银行卡相关
    @IBOutlet weak var addBankCardLB: UILabel!
    @IBOutlet weak var bankCardImg: UIImageView!
    @IBOutlet weak var bankNameLB: UILabel!
    @IBOutlet weak var cardNameLB: UILabel!
    
    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet weak var allMoneyLB: UILabel!
    @IBOutlet weak var moneyTF: UITextField!
    
    //MARK: - 外部属性
    var bankCardModel = UserModel()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现"
        setupUI()
        ///使用通知来实现
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadUserData), name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
    }
    
    func setupUI() {
        moneyTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        allMoneyLB.text = "可提现金额" + String(UserManager.shareManager.userModel.account)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Method
    ///选择银行卡
    @IBAction func changeBtnClick(_ sender: UIButton) {
        let vc = ChoiceBankCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///所有金额
    @IBAction func allMoneyBtn(_ sender: UIButton) {
        moneyTF.text = String(UserManager.shareManager.userModel.account)
    }
    
    //监听textField值的变化
    @objc func textFieldDidChange(_ textField: UITextField) {
        let str = Float(textField.text!) ?? 0.0
        if str > UserManager.shareManager.userModel.account {
            allMoneyLB.text = "超出可提现金额"
        }else {
            allMoneyLB.text = "可提现金额" + String(UserManager.shareManager.userModel.account)
        }
    }
    
    ///确认提现
    @IBAction func commitBtnClick(_ sender: UIButton) {
        guard addBankCardLB.isHidden else {
            JSProgress.showFailStatus(with: "请选择银行卡")
            return
        }
        
        let str = Float(moneyTF.text!) ?? 0.0
        guard str <= UserManager.shareManager.userModel.account else {
            JSProgress.showFailStatus(with: "超出可提现金额")
            return
        }
        
        withdraw()
    }
    
}

//MARK: - 数据处理
extension WithdrawViewController {
    
    ///显示银行卡信息
    func bankCardInfo(_ bankInfo: UserModel) {
        bankCardModel = bankInfo
        addBankCardLB.isHidden = true
        bankCardImg.isHidden = false
        bankNameLB.isHidden = false
        cardNameLB.isHidden = false
        if !bankInfo.logo_small.isEmpty {
            bankCardImg.setImage(with: bankInfo.logo_small)
        }
        bankNameLB.text = bankInfo.bank_full
        cardNameLB.text = "尾号" + bankInfo.last_four + bankInfo.card_type
    }
    
    ///提现
    func withdraw() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["enc_bank_no"] = bankCardModel.card_no
        let money = Float(moneyTF.text!) ?? 0.0
        parameters["amount"] = money
        NetWorksManager.requst(with: kUrl_Withdraw, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                UserManager.shareManager.userModel.account = UserManager.shareManager.userModel.account - money
                let vc = WithdrawCompleteViewController.loadStoryboard()
                self?.navigationController?.pushViewController(vc, animated: true)
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
}
