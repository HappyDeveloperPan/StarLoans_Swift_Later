//
//  ManagerBillApprovalTwoViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/25.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ManagerBillApprovalTwoViewController: BaseViewController, StoryboardLoadable {
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var noPassBtn: UIButton!
    @IBOutlet weak var passBtn: UIButton!
    @IBOutlet weak var noPassTV: AnimatableTextView!
    
    //MARK: - 内部属性
    fileprivate var btnArr =  [UIButton]()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.backgroundColor = kHomeBackColor
        setupBasic()
    }
    
    func setupBasic() {
        
        detailBtn.set(image: #imageLiteral(resourceName: "ICON-youjiantou-"), title: "查看详情", titlePosition: .left, additionalSpacing: 4, state: .normal)
        
        noPassBtn.backgroundColor = kMainColor
        noPassBtn.setTitleColor(UIColor.white, for: .normal)
        noPassBtn.layer.borderWidth = 0
        
        passBtn.layer.borderWidth = 1
        passBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
        passBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
        passBtn.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    
    //MARK: - 控件点击事件
    @IBAction func passBtnClick(_ sender: UIButton) {
        if sender == noPassBtn {
            
            noPassBtn.backgroundColor = kMainColor
            noPassBtn.setTitleColor(UIColor.white, for: .normal)
            noPassBtn.layer.borderWidth = 0
            
            passBtn.layer.borderWidth = 1
            passBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            passBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            passBtn.backgroundColor = UIColor.white
            
            noPassTV.isHidden = false
        }
        if sender == passBtn {
            
            passBtn.backgroundColor = kMainColor
            passBtn.setTitleColor(UIColor.white, for: .normal)
            passBtn.layer.borderWidth = 0
            
            noPassBtn.layer.borderWidth = 1
            noPassBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            noPassBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            noPassBtn.backgroundColor = UIColor.white
            
            noPassTV.isHidden = true
        }
    }
    
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        let vc = ManagerBillApprovalThreeViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
