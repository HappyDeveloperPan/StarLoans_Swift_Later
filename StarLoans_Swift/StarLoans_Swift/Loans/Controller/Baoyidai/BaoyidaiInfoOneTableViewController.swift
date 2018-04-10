//
//  BaoyidaiInfoOneTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class BaoyidaiInfoOneTableViewController: UITableViewController {
    // MARK: - Storyboard连线
    @IBOutlet weak var loanMoneyTF: UITextField!    //贷款金额
    @IBOutlet weak var loanDeadlineTF: UITextField! //贷款期限
    @IBOutlet weak var repaymentTypeLB: UILabel!    //还款方式
    @IBOutlet weak var userNameTF: UITextField! //用户姓名
    @IBOutlet weak var sexView: RadioBtnView!   //性别
    @IBOutlet weak var ageTF: UITextField!  //年龄
    @IBOutlet weak var marriageLB: UILabel! //婚姻
    
    // MARK: - 外部属性
    var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 内部属性
    let headArr:Array<String> = ["借款需求", "个人信息"]
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }
    
    func setUpBasic() {
        sexView.hSingleSelBtn(titleArray: ["男","女"], typeE: 1)
        sexView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 3
            case 1: return 4
            default: break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = headArr[section]
        return view
    }
    
    // MARK: - 控件点击事件
    
    /// 还款方式
    ///
    /// - Parameter sender: 按钮
    @IBAction func repaymentTypeBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.repaymentTypeLB.text = selectValue as? String
        }
    }
    
    /// 婚姻
    ///
    /// - Parameter sender: 按钮
    @IBAction func marriageBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.marriageLB.text = selectValue as? String
        }
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = BaoyidaiInfoTwoViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 单选框按钮
extension BaoyidaiInfoOneTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case sexView:print("sexView被点击")
        default:break
        }
    }
    
}
