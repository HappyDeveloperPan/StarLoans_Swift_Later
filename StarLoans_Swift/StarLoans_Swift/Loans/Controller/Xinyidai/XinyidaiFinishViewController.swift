//
//  XinyidaiFinishViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiFinishViewController: BaseViewController, StoryboardLoadable {
    @IBOutlet weak var finishBtn: AnimatableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "录入客户信息"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
    
    // MARK: - 控件点击事件
    @IBAction func finishBtnClick(_ sender: AnimatableButton) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.popToRootViewController(animated: true)
    }
    
}
