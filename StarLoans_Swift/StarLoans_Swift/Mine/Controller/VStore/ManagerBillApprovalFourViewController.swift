//
//  ManagerBillApprovalFourViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/25.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ManagerBillApprovalFourViewController: BaseViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var uploadImgBtn: UIButton!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.backgroundColor = kHomeBackColor
        setupBasic()
    }
    
    func setupBasic() {
        detailBtn.set(image: #imageLiteral(resourceName: "ICON-youjiantou-"), title: "查看详情", titlePosition: .left, additionalSpacing: 4, state: .normal)
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

    //MARK: - 控件点击事件
    ///上传图片
    @IBAction func uploadImgBtnClick(_ sender: UIButton) {
        
    }
    ///确认按钮
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        let vc = ManagerBillApprovalFiveViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
