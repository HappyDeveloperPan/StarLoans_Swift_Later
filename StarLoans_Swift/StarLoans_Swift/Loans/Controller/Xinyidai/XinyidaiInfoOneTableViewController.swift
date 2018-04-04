//
//  XinyidaiInfoOneTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiInfoOneTableViewController: UITableViewController {

    // MARK: - Storyboard
    @IBOutlet weak var loansMoney: UITextField! //贷款金额
    @IBOutlet weak var userNameTF: UITextField! //客户姓名
    @IBOutlet weak var sexView: RadioBtnView!   //性别
    @IBOutlet weak var phoneTF: UITextField!    //电话号码
    @IBOutlet weak var IDCardTF: UITextField!   //身份证
    @IBOutlet weak var IDcardExpiryDateLB: UILabel! //身份证有效期
    @IBOutlet weak var expiryDateBtn: UIButton!
    @IBOutlet weak var certificateLocLB: UILabel!   //发证机关所在地
    @IBOutlet weak var educationLB: UILabel!    //教育程度
    @IBOutlet weak var marriageLB: UILabel! //婚姻状态
    @IBOutlet weak var childrenTF: UITextField! //子女状况
    @IBOutlet weak var creditLoanLB: UILabel!   //信贷状况
    
    // MARK: - 内部属性
    fileprivate var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBasic() {
        sexView.hSingleSelBtn(titleArray: ["男","女"], typeE: 1)
        sexView.delegate = self
    }
    
    //MARK: - 控件点击事件
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = XinyidaiInfoTwoViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = "基本情况"
        return view
    }

    // MARK: - 控件点击事件
    
    /// 身份证有效期
    ///
    /// - Parameter sender: 按钮
    @IBAction func IDcardExpiryDateBtnClick(_ sender: UIButton) {
        let date = Date()
        let format = DateFormatter()
        format.date(from: "yyyy-MM-dd HH:mm:ss")
        let nowStr = format.string(from: date)
        CGXPickerView.showDatePicker(withTitle: "", dateType: .date, defaultSelValue: nil, minDateStr: "1900-01-01 00:00:00", maxDateStr: nowStr, isAutoSelect: false, manager: nil) { [weak self] (selectValue) in
            self?.IDcardExpiryDateLB.text = selectValue
        }
    }
    
    /// 身份证是否长期有效
    ///
    /// - Parameter sender: 按钮
    @IBAction func expiryDateBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    /// 发证机关所在地
    ///
    /// - Parameter sender: 按钮
    @IBAction func certificateLocBtnCLick(_ sender: UIButton) {
        CGXPickerView.showAddressPicker(withTitle: "", defaultSelected: [0,0,0], isAutoSelect: false, manager: nil) { [weak self] (selectAddressArr, selectAddressRow) in
            let arr = selectAddressArr as? Array<String>
            self?.certificateLocLB.text = arr![0] + arr![1] + arr![2]
        }
    }
    
    /// 教育程度
    ///
    /// - Parameter sender: 按钮
    @IBAction func educationBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.educationLB.text = selectValue as? String
        }
    }
    
    /// 婚姻状态
    ///
    /// - Parameter sender: 按钮
    @IBAction func marriageBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.marriageLB.text = selectValue as? String
        }
    }
    
    /// 信贷状况
    ///
    /// - Parameter sender: 按钮
    @IBAction func creditLoanBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.creditLoanLB.text = selectValue as? String
        }
    }
}

//MARK: - 数据处理
extension XinyidaiInfoOneTableViewController {
    ///获取下拉框数据
    func getComboBoxData() {
        var parameters = [String: Any]()
        parameters["fields"] = "occupation,payment_type,house_type,car_type,credit,loan_type"
        NetWorksManager.requst(with: kUrl_ComboBox, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    self?.comboBoxModel = ComboBoxModel(with: data)
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

//MARK: - 单选框按钮
extension XinyidaiInfoOneTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case sexView:print("sexView被点击")
        default:break
        }
    }
    
}
