//
//  PayCompleteViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/13.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class PayCompleteViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var lookTextBtn: UIButton!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "完成支付"
        basicConfig()
    }
    
    func basicConfig() {
        lookTextBtn.layer.cornerRadius = lookTextBtn.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func lookTextClik(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
