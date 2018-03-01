//
//  BaseViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/14.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var isNavLineHidden: Bool = true {
        didSet {
           (navigationController as? AXDNavigationController)?.navBarHairlineImageView?.isHidden = isNavLineHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension BaseViewController {
    func popToUpperViewController<T :UIViewController>(with upperController: T) {
        //跳转回银行卡界面并且刷新
        for controller: UIViewController in (navigationController?.viewControllers)! {
            if (controller is T) {
                let vc = controller as? T
                navigationController?.popToViewController(vc ?? UIViewController(), animated: true)
            }
        }
    }
}
