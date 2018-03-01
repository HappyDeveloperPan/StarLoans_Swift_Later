//
//  SettingTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            //如果用户没有登录就跳转到登录界面
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .oldLoginPass
            navigationController?.pushViewController(vc, animated: true)
        case [0, 1]:
            //如果用户没有登录就跳转到登录界面
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .transactionPass
            navigationController?.pushViewController(vc, animated: true)
        case [0, 2]:
            //如果用户没有登录就跳转到登录界面
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .newPhoneNum
            navigationController?.pushViewController(vc, animated: true)
        case [1, 0]:
            let vc = SettingInformAdminViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case [1, 1]: 
            JSProgress.showSucessStatus(with: "清理缓存成功")
        case [1, 2]:
            let vc = OpinionFeedbackViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
