//
//  AboutTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let appStoreUrl = URL(string: "itms-apps://itunes.apple.com/app/id1338709961?action=write-review")
            if UIApplication.shared.canOpenURL(appStoreUrl!) {
                UIApplication.shared.openURL(appStoreUrl!)
            }
            UIApplication.shared.openURL(appStoreUrl!)
        case 1:
            let vc = BaseWebViewController()
            vc.url = "http://120.78.171.83/iOS/mobile/privacy/server_text.html"
            vc.title = "服务条款"
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = BaseWebViewController()
            vc.url = "http://120.78.171.83/iOS/mobile/privacy/user_text.html"
            vc.title = "隐私条款"
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }

}
