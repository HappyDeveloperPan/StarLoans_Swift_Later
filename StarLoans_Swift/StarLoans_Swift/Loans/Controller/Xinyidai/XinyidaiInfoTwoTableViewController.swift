//
//  XinyidaiInfoTwoTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiInfoTwoTableViewController: UITableViewController {
    // MARK: - Storyboard控件连线
    @IBOutlet weak var houseInfoLB: UILabel!    //房产信息
    @IBOutlet weak var houseInfoBtn: UIButton!
    @IBOutlet weak var houseAreaTF: UITextField!    //房产面积
    @IBOutlet weak var houseAppraisement: UITextField!  //房产估值
    @IBOutlet weak var liveConditionLB: UILabel!    //居住状况
    @IBOutlet weak var liveConditionBtn: UIButton!
    @IBOutlet weak var liveAdressLB: UILabel!   //居住地址
    @IBOutlet weak var liveAdressBtn: UIButton!
    @IBOutlet weak var liveAdressDetailTF:   UITextField!   //详细地址
    @IBOutlet weak var censusRegisterView: RadioBtnView!    //户籍类型
    @IBOutlet weak var censusRegisterSortView: RadioBtnView!    //户籍类别
    
    // MARK: - 外部属性
    var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 控件点击事件
    
    /// 下一步按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = XinyidaiInfoThreeViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = "家庭信息"
        return view
    }

    // MARK: - 控件点击事件
    
    /// 选择房产信息
    ///
    /// - Parameter sender: 按钮
    @IBAction func houseInfoBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.houseInfoLB.text = selectValue as? String
        }
    }
    
    /// 选择居住状况
    ///
    /// - Parameter sender: 按钮
    @IBAction func liveConditionBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.liveConditionLB.text = selectValue as? String
        }
    }
    
    /// 选择居住地址
    ///
    /// - Parameter sender: 按钮
    @IBAction func liveAdressBtnClick(_ sender: UIButton) {
        CGXPickerView.showAddressPicker(withTitle: "", defaultSelected: [0,0,0], isAutoSelect: false, manager: nil) { [weak self] (selectAddressArr, selectAddressRow) in
            let arr = selectAddressArr as? Array<String>
            self?.liveAdressLB.text = arr![0] + arr![1] + arr![2]
        }
    }
    
}
