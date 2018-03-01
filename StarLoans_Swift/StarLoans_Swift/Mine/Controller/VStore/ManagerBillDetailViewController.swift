//
//  ManagerBillDisposeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/7.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ManagerBillDetailViewController: BaseViewController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
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
    
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let vc = ManagerBillApprovalViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
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
