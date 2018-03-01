//
//  BindingCardNextViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/19.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class BindingCardNextViewController: UIViewController, StoryboardLoadable {
    //MARK: - 外部属性
    var userName: String = ""
    var bankCardNumber: String = ""
    var phoneNumber: String = ""
    var bankCardModel = UserModel()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "绑定银行卡"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! BindingCardNextTableViewController
        vc.userName = userName
        vc.bankCardNumber = bankCardNumber
        vc.phoneNumber = phoneNumber
        vc.bankCardModel = bankCardModel
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
