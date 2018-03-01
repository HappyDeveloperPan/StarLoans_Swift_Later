//
//  PurchasedCourseDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/6.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PurchasedCourseDetailViewController: BaseViewController, StoryboardLoadable {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var fromLB: UILabel!
    @IBOutlet weak var readNumLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "推单教学"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
