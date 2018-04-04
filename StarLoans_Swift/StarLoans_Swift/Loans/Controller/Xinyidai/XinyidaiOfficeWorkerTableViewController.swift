//
//  XinyidaiOfficeWorkerTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiOfficeWorkerTableViewController: UITableViewController {

    // MARK: - Storyboard
    @IBOutlet weak var monthIncomeTF: UITextField!  //税前月收入
    @IBOutlet weak var salaryShapeLB: UILabel!  //工资发放形式
    @IBOutlet weak var seniorityTF: UITextField!    //工龄
    @IBOutlet weak var socialSecurityView: RadioBtnView!    //社保购买情况
    @IBOutlet weak var socialSecurityTF: UITextField!   //社保购买月数
    @IBOutlet weak var providentFundView: RadioBtnView! //公积金购买情况
    @IBOutlet weak var providentFundTF: UITextField!    //公积金余额
    @IBOutlet weak var insuranceView: RadioBtnView! //保险购买情况
    @IBOutlet weak var insuranceTF: UITextField!    //保险购买时长
    @IBOutlet weak var organizationTF: UITextField!
    @IBOutlet weak var organizationNatureLB: UILabel!   //单位性质
    @IBOutlet weak var organizationAdressLB: UILabel!   //单位地址
    @IBOutlet weak var organizaDetailAdressTF: UITextField! //详细地址
    @IBOutlet weak var organizaPhoneTF: UITextField!    //单位电话
    
    // MARK: - 外部属性
    var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }

    // MARK: - 控件点击事件
    
    /// 工资发放形式
    ///
    /// - Parameter sender: 按钮
    @IBAction func salaryShapeBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.salaryShapeLB.text = selectValue as? String
        }
    }
    
    /// 单位性质
    ///
    /// - Parameter sender: 按钮
    @IBAction func organizationNatureBtnClick(_ sender: UIButton) {
    }
    
    /// 单位地址
    ///
    /// - Parameter sender: 按钮
    @IBAction func organizationAdressBtnClick(_ sender: UIButton) {
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = XinyidaiInfoFourViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
