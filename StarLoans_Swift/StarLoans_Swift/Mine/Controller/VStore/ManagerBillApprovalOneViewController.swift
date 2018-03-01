//
//  ManagerBillApprovalOneViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/25.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ManagerBillApprovalOneViewController: BaseViewController, StoryboardLoadable {

    //MARK: - storyboard连线
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var contentLB: UILabel!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
//        "开始受理此订单后，即表明您已为此客户开始办理业务，即将进入下一步流程。"
        view.backgroundColor = kHomeBackColor
        setupBasic()
    }
    
    func setupBasic() {
        detailBtn.set(image: #imageLiteral(resourceName: "ICON-youjiantou-"), title: "查看详情", titlePosition: .left, additionalSpacing: 4, state: .normal)
        contentLB.sizeToFit()
        contentLB.numberOfLines = 0
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
    
    //MARK: - 控件点击事件
    @IBAction func detaliBtnClick(_ sender: UIButton) {
        let vc = BaseWebViewController()
        vc.title = "客户详情"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        let vc = ManagerBillApprovalTwoViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
