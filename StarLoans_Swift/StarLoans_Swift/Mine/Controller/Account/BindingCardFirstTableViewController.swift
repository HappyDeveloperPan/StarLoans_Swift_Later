//
//  BindingCardFirstTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/19.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class BindingCardFirstTableViewController: UITableViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var bankCardNumberTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        nextBtn.layer.cornerRadius = nextBtn.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Method
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        guard !((userNameTF.text?.isEmpty)!) else {
            JSProgress.showFailStatus(with: "请填写姓名")
            return
        }
        guard !((bankCardNumberTF.text?.isEmpty)!) else {
            JSProgress.showFailStatus(with: "请填写银行卡号")
            return
        }
        guard !((phoneNumberTF.text?.isEmpty)!) else {
            JSProgress.showFailStatus(with: "请填写手机号")
            return
        }
        
        guard (phoneNumberTF.text?.judgeMobileNumber())! else {
            JSProgress.showFailStatus(with: "请填写正确的手机号")
            return
        }
        
        getBankCardInfo()
        
//        let vc = BindingCardNextViewController.loadStoryboard()
//        vc.userName = userNameTF.text!
//        vc.bankCardNumber = bankCardNumberTF.text!
//        vc.phoneNumber = phoneNumberTF.text!
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }else {
            return 1
        }
    }
}

extension BindingCardFirstTableViewController {
    ///获取银行卡信息
    func getBankCardInfo() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["card_id"] = bankCardNumberTF.text
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_BankCardInfo, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    let bankCardModel = UserModel(with: data)
                    let vc = BindingCardNextViewController.loadStoryboard()
                    vc.userName = (self?.userNameTF.text)!
                    vc.bankCardNumber = (self?.bankCardNumberTF.text)!
                    vc.phoneNumber = (self?.phoneNumberTF.text)!
                    vc.bankCardModel = bankCardModel
                    self?.navigationController?.pushViewController(vc, animated: true)
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
}
