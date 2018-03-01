//
//  WithdrawCompleteViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/24.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class WithdrawCompleteViewController: BaseViewController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现成功"
        // Do any additional setup after loading the view.
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
    
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
