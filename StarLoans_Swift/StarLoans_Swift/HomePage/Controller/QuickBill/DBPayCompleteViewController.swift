//
//  DBPayCompleteViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class DBPayCompleteViewController: BaseViewController, StoryboardLoadable {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var phoneNumLB: UILabel!
    @IBOutlet weak var commitBtn: UIButton!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "完成支付"
        
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //拨打电话
    @IBAction func phoneBtnClick(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "tel://" + phoneNumLB.text!)!)
    }
}
