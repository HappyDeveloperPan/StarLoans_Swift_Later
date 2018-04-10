//
//  BaoyidaiInfoThreeTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class BaoyidaiInfoThreeTableViewController: UITableViewController {
    // MARK: - Storyboard连线
    @IBOutlet weak var communityTF: UITextField!    //小区名
    @IBOutlet weak var areaTF: UITextField! //面积
    @IBOutlet weak var appraisementTF: UITextField! //估值
    @IBOutlet weak var houseStateView: RadioBtnView!    //房产状态
    @IBOutlet weak var amountTF: UITextField!   //金额
    @IBOutlet weak var propertyView: RadioBtnView!  //其他资产
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }
    
    func setUpBasic() {
        houseStateView.hSingleSelBtn(titleArray: ["红本房","按揭房","抵押房"], typeE: 1)
        houseStateView.delegate = self
        propertyView.hSingleSelBtn(titleArray: ["车辆","股票","理财","其他"], typeE: 1)
        propertyView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    // MARK: - 控件点击事件
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = BaoyidaiInfoFourViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - 单选框按钮
extension BaoyidaiInfoThreeTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case houseStateView:print("houseStateView被点击")
        case propertyView:print("propertyView被点击")
        default:break
        }
    }
    
}
