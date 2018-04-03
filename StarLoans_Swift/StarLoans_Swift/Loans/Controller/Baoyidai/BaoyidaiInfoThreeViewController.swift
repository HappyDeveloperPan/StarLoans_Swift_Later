//
//  BaoyidaiInfoThreeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class BaoyidaiInfoThreeViewController: BaseViewController, StoryboardLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "录入客户信息"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
