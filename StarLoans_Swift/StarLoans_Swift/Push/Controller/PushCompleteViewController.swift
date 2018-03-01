//
//  PushCompleteViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class PushCompleteViewController: BaseViewController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提交成功"
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
//        for controller: UIViewController in (navigationController?.viewControllers)! {
//            if (controller is ApproveSelectViewController) {
//                let vc = controller as? ApproveSelectViewController
//                navigationController?.popToViewController(vc ?? UIViewController(), animated: true)
//            }
//        }
        navigationController?.popToRootViewController(animated: true)
    }
}
