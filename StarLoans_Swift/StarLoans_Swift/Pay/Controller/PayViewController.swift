//
//  PayViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/10.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PayViewController: BaseViewController, StoryboardLoadable {

    //MARK: - 外部属性
    var price: Float = 0
    var goodsId: Int = 0
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待支付"
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
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PayTableViewController
        vc.goodsId = goodsId
        vc.price = price
    }
}
