//
//  VStoreSegmentViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/6.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class VStoreSegmentViewController: SegmentViewController {
    //MARK: - 懒加载
    
    //MARK: - 外部属性
    var storeType: VStoreType = .broker
    var segmentIndex: Int = 0
    //MARK: - 内部属性
    fileprivate let managerTitleArr: [String] = ["全部", "待受理", "待反馈", "待审批", "待放款", "未通过", "已完成"]
    fileprivate let brokerTitleArr: [String] = ["全部", "已代理客户", "已发产品", "收到交单", "已购资源", "已发资源", "已完成"]
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "微店订单"
        if self.storeType == .broker {
            for i in 0...brokerTitleArr.count-1 {
                let vc = VStoreListViewController()
                vc.title = brokerTitleArr[i]
                vc.storeType = storeType
                addChildViewController(vc)
            }
        }else {
            for i in 0...managerTitleArr.count-1 {
                let vc = VStoreListViewController()
                vc.title = managerTitleArr[i]
                vc.storeType = storeType
                addChildViewController(vc)
            }
        }
        selectedSegmentIndex = segmentIndex
//        for i in 0...managerTitleArr.count-1 {
//            let vc = VStoreListViewController()
//            vc.title = managerTitleArr[i]
//            addChildViewController(vc)
//        }
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

}
