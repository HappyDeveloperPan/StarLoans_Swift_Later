//
//  ChoiceBankCardViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/24.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ChoiceBankCardViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.backgroundColor = kHomeBackColor
        tableView.pan_registerCell(cell: ChoiceBankCardCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    
    //MARK: - 内部属性
    fileprivate var bankCardArr = [UserModel]()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择银行卡"
        view.backgroundColor = kHomeBackColor
        tableView.addHeaderRefresh { [weak self] in
            self?.getChoiceBankCardData()
        }
        tableView.beginHeaderRefresh()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.right.bottom.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: - 数据处理
extension ChoiceBankCardViewController {
    ///获取银行卡列表
    func getChoiceBankCardData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        NetWorksManager.requst(with: kUrl_BankCardList, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var bankDataArr = [UserModel]()
                    for data in dataArr {
                        bankDataArr.append(UserModel(with: data))
                    }
                    self?.bankCardArr = bankDataArr
                    self?.tableView.reloadData()
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
            self?.tableView.endHeaderRefresh()
        }
    }
}

//MARK: - UITableView代理
extension ChoiceBankCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankCardArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as ChoiceBankCardCell
        cell.setBankCardCellData(bankCardArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转回银行卡界面并且刷新
        for controller: UIViewController in (navigationController?.viewControllers)! {
            if (controller is WithdrawViewController) {
                let revise = controller as? WithdrawViewController
//                revise?.bankCardModel = bankCardArr[indexPath.row]
                revise?.bankCardInfo(bankCardArr[indexPath.row])
                navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
            }
        }
//        navigationController?.popViewController(animated: true)
        print("")
    }
}
