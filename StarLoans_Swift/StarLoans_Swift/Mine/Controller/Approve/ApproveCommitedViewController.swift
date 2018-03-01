//
//  ApproveCommitedViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/15.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ApproveCommitedViewController: BaseViewController, StoryboardLoadable {
    
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
        
    }
    
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        for controller: UIViewController in (navigationController?.viewControllers)! {
            if (controller is ApproveSelectViewController) {
                let vc = controller as? ApproveSelectViewController
                navigationController?.popToViewController(vc ?? UIViewController(), animated: true)
            }
        }
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
