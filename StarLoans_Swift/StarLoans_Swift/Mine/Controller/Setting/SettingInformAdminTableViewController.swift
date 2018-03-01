//
//  SettingInformAdminTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class SettingInformAdminTableViewController: UITableViewController {
    @IBOutlet weak var pushLB: UILabel!
    @IBOutlet weak var systemSwitch: UISwitch!
    @IBOutlet weak var transactionSwitch: UISwitch!
    @IBOutlet weak var activitySwitch: UISwitch!
    
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
        if section == 0 {
            return 1
        }else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

}
