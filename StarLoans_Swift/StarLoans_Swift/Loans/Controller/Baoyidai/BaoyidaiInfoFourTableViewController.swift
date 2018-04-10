//
//  BaoyidaiInfoFourTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class BaoyidaiInfoFourTableViewController: UITableViewController {

    // MARK: - Storyboard连线
    @IBOutlet weak var creditCardView: RadioBtnView!    //有无信用卡
    @IBOutlet weak var creditLimitTF: UITextField!  //信用卡总额度
    @IBOutlet weak var creditLimitUseTF: UITextField!
    @IBOutlet weak var creditLoansView: RadioBtnView!   //有无信用贷款
    @IBOutlet weak var loansLimitTF: UITextField!   //信用贷款额度
    @IBOutlet weak var monthRepaymentTF: UITextField!   //月还款总额
    @IBOutlet weak var carLoanView: RadioBtnView!   //有无车贷
    @IBOutlet weak var carLoanLimitTF: UITextField! //车贷额度
    @IBOutlet weak var monthRepaymentLimitTF: UITextField!  //月还款额度
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }
    
    func setUpBasic() {
        creditCardView.hSingleSelBtn(titleArray: ["有","无"], typeE: 1)
        creditCardView.delegate = self
        creditLoansView.hSingleSelBtn(titleArray: ["有","无"], typeE: 1)
        creditLoansView.delegate = self
        carLoanView.hSingleSelBtn(titleArray: ["有","无"], typeE: 1)
        carLoanView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    // MARK: - 控件点击事件
    
    /// 用户授权
    ///
    /// - Parameter sender: 按钮
    @IBAction func authorizationBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = BaoyidaiFinishViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 单选框按钮
extension BaoyidaiInfoFourTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case creditCardView:print("creditCardView被点击")
        case creditLoansView:print("creditLoansView被点击")
        case carLoanView:print("carLoanView被点击")
        default:break
        }
    }
    
}
