//
//  BindingCardNextTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/19.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class BindingCardNextTableViewController: UITableViewController {

    //MARK: - Storyboard连线
    @IBOutlet weak var bankCardName: UILabel!
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var bankCarNum: UILabel!
    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet weak var verCodeBtn: VerCodeButton!
    @IBOutlet weak var verCodeTF: UITextField!
    
    //MARK: - 外部属性
    var userName: String = ""
    var bankCardNumber: String = ""
    var phoneNumber: String = ""
    var bankCardModel = UserModel()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBasicData()
    }
    
    func setupUI() {
        verCodeBtn.delegate = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }
    
    func setupBasicData() {
        let startIndex = bankCardNumber.index(bankCardNumber.startIndex, offsetBy: 0)
        let endIndex = bankCardNumber.index(startIndex, offsetBy: bankCardNumber.count - 4)
        let range = startIndex..<endIndex
        bankCarNum.text = bankCardNumber.replacingCharacters(in: range, with: "********")
        bankImg.setImage(with: bankCardModel.logo_small)
        bankCardName.text = bankCardModel.name_short
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Method

    @IBAction func commitBtnClick(_ sender: UIButton) {
        guard !((verCodeTF.text?.isEmpty)!) else {
            JSProgress.showFailStatus(with: "请填写验证码")
            return
        }
        
        guard judgeVerCode() else {
            JSProgress.showFailStatus(with: "请填写正确的验证码")
            return
        }
        
        commitCardbankData()
        
        //跳转回银行卡界面并且刷新
//        for controller: UIViewController in (navigationController?.viewControllers)! {
//            if (controller is BankCardViewController) {
//                let revise = controller as? BankCardViewController
//                navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
//            }
//        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

}

extension BindingCardNextTableViewController {
    
    ///判断验证码是否输入正确
    func judgeVerCode() -> Bool {
        return (verCodeTF.text == bankCardModel.yzm) ? true : false
    }
    
    ///获取验证码
    func getVerCode() {
        var parameters = [String: Any]()
        parameters["user"] = phoneNumber
        NetWorksManager.requst(with: kUrl_GetCode, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    self?.bankCardModel.yzm = UserModel(with: data).yzm
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
    
    ///提交数据
    func commitCardbankData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["name"] = userName
        parameters["no"] = bankCardNumber
        parameters["code"] = verCodeTF.text
        parameters["phone"] = phoneNumber
        NetWorksManager.requst(with: kUrl_BankCardAdd, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                //跳转回银行卡界面并且刷新
                for controller: UIViewController in (self?.navigationController?.viewControllers)! {
                    if (controller is BankCardViewController) {
                        let revise = controller as? BankCardViewController
                        self?.navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
                    }
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

extension BindingCardNextTableViewController: VerCodeButtonDelegate {
    func verCodeBtnClick(clickHandler: (Bool) -> ()) {
        clickHandler(true)
        getVerCode()
    }

}
