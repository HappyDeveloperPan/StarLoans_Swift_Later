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
    // MARK: - 内部属性
    let headArr:Array<String> = ["借款需求", "个人信息"]
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - 空间点击事件
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = BaoyidaiInfoTwoViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
