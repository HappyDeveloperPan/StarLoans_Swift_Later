//
//  IDApproveViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class IDApproveViewController: BaseViewController, StoryboardLoadable {
    
    //MARK: - 可操作数据
    var approveType: ApproveType = .managerIdentity
    var approveModel: ApproveModel = ApproveModel()
    var cardFront: UIImageView = UIImageView()
    var cardBackend: UIImageView = UIImageView()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        switch approveType {
        case .brokerIdentity, .brokerJob:
            title = "经纪人认证"
        case .managerIdentity, .managerJob:
            title = "机构经理认证"
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! IDApproveTableViewController
        vc.approveType = approveType
        vc.approveModel = approveModel
        vc.cardFront = cardFront
        vc.cardBackend = cardBackend
    }

}
