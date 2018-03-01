//
//  ManagerBillApprovalFiveViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/25.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ManagerBillApprovalFiveViewController: BaseViewController, StoryboardLoadable {

    //MARK: - Storyboard连线
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var uploadImgBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.backgroundColor = kHomeBackColor
        setupBasic()
    }
    
    func setupBasic() {
        detailBtn.set(image: #imageLiteral(resourceName: "ICON-youjiantou-"), title: "查看详情", titlePosition: .left, additionalSpacing: 4, state: .normal)
        uploadImgBtn.set(image: #imageLiteral(resourceName: "ICON-tianjia"), title: "请上传放款凭证", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
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
    ///确认按钮
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        for controller: UIViewController in (navigationController?.viewControllers)! {
            if (controller is VStoreSegmentViewController) {
                let vc = controller as? VStoreSegmentViewController
                navigationController?.popToViewController(vc ?? UIViewController(), animated: true)
            }
        }
    }
}
