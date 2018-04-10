//
//  XinyidaiEntrepreneurTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiEntrepreneurTableViewController: UITableViewController {
    // MARK: - Storyboard连线
    @IBOutlet weak var runAgeLimitTF: UITextField!  //经营年限
    @IBOutlet weak var runSerialTF: UITextField!    //经营流水
    @IBOutlet weak var runSerialMonthTF: UITextField!   //月经营流水
    @IBOutlet weak var registerAdressLB: UILabel!   //公司注册地
    @IBOutlet weak var socialSecurityView: RadioBtnView!    //社保购买情况
    @IBOutlet weak var socialSecurityTF: UITextField!   //社保购买月数
    @IBOutlet weak var providentFundView: RadioBtnView! //公积金购买情况
    @IBOutlet weak var providentFundTF: UITextField!    //公积金余额
    @IBOutlet weak var unitNameTF: UITextField! //单位名称
    @IBOutlet weak var unitNatureLB: UILabel!   //单位性质
    @IBOutlet weak var unitAddressLB: UILabel!  //单位地址
    @IBOutlet weak var addressDetailTF: UITextField!    //详细地址
    @IBOutlet weak var unitPhoneTF: UITextField!    //单位电话
    
    // MARK: - 外部属性
    var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }
    
    func setUpBasic() {
        socialSecurityView.hSingleSelBtn(titleArray: ["有社保","无社保"], typeE: 1)
        socialSecurityView.delegate = self
        providentFundView.hSingleSelBtn(titleArray: ["有公积金","无公积金"], typeE: 1)
        providentFundView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    // MARK: - 控件点击事件
    
    /// 公司注册地选择
    ///
    /// - Parameter sender: 按钮
    @IBAction func registerAdressBtnClick(_ sender: UIButton) {
        CGXPickerView.showAddressPicker(withTitle: "", defaultSelected: [0,0,0], isAutoSelect: false, manager: nil) { [weak self] (selectAddressArr, selectAddressRow) in
            let arr = selectAddressArr as? Array<String>
            self?.registerAdressLB.text = arr![0] + arr![1] + arr![2]
        }
    }
    
    /// 单位性质
    ///
    /// - Parameter sender: 按钮
    @IBAction func unitNatureBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.unitNatureLB.text = selectValue as? String
        }
    }
    
    /// 单位地址
    ///
    /// - Parameter sender: 按钮
    @IBAction func unitAddressBtnClick(_ sender: UIButton) {
        CGXPickerView.showAddressPicker(withTitle: "", defaultSelected: [0,0,0], isAutoSelect: false, manager: nil) { [weak self] (selectAddressArr, selectAddressRow) in
            let arr = selectAddressArr as? Array<String>
            self?.unitAddressLB.text = arr![0] + arr![1] + arr![2]
        }
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = XinyidaiInfoFourViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - 单选框按钮
extension XinyidaiEntrepreneurTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case socialSecurityView:print("socialSecurityView被点击")
        case providentFundView:print("providentFundView被点击了")
        default:break
        }
    }
    
}
