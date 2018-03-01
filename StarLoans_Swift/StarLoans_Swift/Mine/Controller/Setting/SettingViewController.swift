//
//  SettingViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController, StoryboardLoadable {
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        logoutBtn.layer.cornerRadius = logoutBtn.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtnClick(_ sender: UIButton) {
        UserManager.shareManager.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
