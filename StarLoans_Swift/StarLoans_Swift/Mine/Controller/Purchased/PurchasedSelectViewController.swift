//
//  PurchasedSelectViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PurchasedSelectViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var segmentView: SelectScrollview = { [unowned self] in
        let segmentView = SelectScrollview()
        segmentView.arrTitle = ["全部","视频","推广工具","文案教程"]
        var arr:[UIViewController] = []
        for index in 0..<segmentView.arrTitle!.count {
            let vc = PurchasedViewController()
            arr.append(vc)
        }
        segmentView.viewControllers = arr
        self.view.addSubview(segmentView)
        return segmentView
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentView.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        segmentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
