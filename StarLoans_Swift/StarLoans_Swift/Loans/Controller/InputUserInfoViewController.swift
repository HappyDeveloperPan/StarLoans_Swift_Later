//
//  InputUserInfoViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class InputUserInfoViewController: BaseViewController, StoryboardLoadable {
    //MARK: - 外部属性
    var productId: Int = 0
    var loansProductType: LoansProductType = .selfSupport //产品类别
    var loanClientType: LoanClientType = .personage //用户类别

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        if loanClientType == .personage {
            title = "客户信息录入"
        }else {
            title = "企业信息录入"
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InputUserInfoTableViewController
        vc.productId = productId
        vc.loansProductType = loansProductType
        vc.loanClientType = loanClientType
    }

}
