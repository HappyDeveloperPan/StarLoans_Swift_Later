//
//  MineViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/15.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, StoryboardLoadable {
    //MARK: - 控件
    @IBOutlet weak var containerView: UIView!
    
    weak var navController: UINavigationController?
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.delegate = self
        navController = navigationController
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK: - UINavigationController代理
extension MineViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navController?.setNavigationBarHidden(true, animated: animated)
        }
        else {
            //不在本页时，显示真正的nav bar
            navController?.setNavigationBarHidden(false, animated: animated)
            //当不显示本页时，要么就push到下一页，要么就被pop了，那么就将delegate设置为nil，防止出现BAD ACCESS
            //之前将这段代码放在viewDidDisappear和dealloc中，这两种情况可能已经被pop了，self.navigationController为nil，这里采用手动持有navigationController的引用来解决
            if navController?.delegate === self  {
                //如果delegate是自己才设置为nil，因为viewWillAppear调用的比此方法较早，其他controller如果设置了delegate就可能会被误伤
                navController?.delegate = nil
            }
        }
    }
}

