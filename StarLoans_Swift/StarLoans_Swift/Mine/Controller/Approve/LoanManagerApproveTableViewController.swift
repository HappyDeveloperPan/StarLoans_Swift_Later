//
//  LoanManagerApproveTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/15.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class LoanManagerApproveTableViewController: UITableViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var sexView: RadioBtnView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var IDCardTF: UITextField!
    @IBOutlet weak var storeLB: UILabel!
    @IBOutlet weak var selectStoreBtn: UIButton!
    //MARK: - 可操作数据
    var sex: Int = 0
    var storeNameId: Int = 0
    var storeNameArr: [Any] = [Any]()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        sexView.hSingleSelBtn(titleArray: ["男", "女"], typeE: 1)
        sexView.delegate = self
        getStoreList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    @IBAction func selectStoreBtnClick(_ sender: UIButton) {
        //选择门店
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.storeLB.text = title
            self?.storeNameId = num + 1
        }
//        pickerView.nameArr = ["股份制企业","民营企业","个体经营"]
        pickerView.nameArr = storeNameArr
        kMainWindow??.addSubview(pickerView)
    }
    
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["type"] = 3
        parameters["name"] = nameTF.text
        parameters["phone"] = phoneTF.text
        parameters["cardid"] = IDCardTF.text
        parameters["sex"] = sex
        parameters["store_id"] = storeNameId
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_AddApprove, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                UserManager.shareManager.userModel.is_audit = 2
                let vc = ApproveCommitedViewController.loadStoryboard()
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

extension LoanManagerApproveTableViewController {
    func getStoreList() {
        
        NetWorksManager.requst(with: kUrl_ApproveStore, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var storeNameArr = [Any]()
                    for dict in data {
                        let storeModel = ApproveModel(with: dict)
                        storeNameArr.append(storeModel.store_name)
//                        storeNameArr.add(storeModel.store_name)
                    }
                    self?.storeNameArr = storeNameArr
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

extension LoanManagerApproveTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        sex = index + 1
    }
    
}
