//
//  ManagerBillApprovalThreeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/25.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class ManagerBillApprovalThreeViewController:BaseViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var noPassBtn: UIButton!
    @IBOutlet weak var passBtn: UIButton!
    @IBOutlet weak var uploadImgBtn: UIButton!
    @IBOutlet weak var reasonTV: AnimatableTextView!
    @IBOutlet weak var setTimeView: AnimatableView!
    
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
        uploadImgBtn.set(image: #imageLiteral(resourceName: "ICON-tianjia"), title: "请上传批复函", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        
        noPassBtn.backgroundColor = kMainColor
        noPassBtn.setTitleColor(UIColor.white, for: .normal)
        noPassBtn.layer.borderWidth = 0
        
        passBtn.layer.borderWidth = 1
        passBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
        passBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
        passBtn.backgroundColor = UIColor.white
        
        uploadImgBtn.isHidden = true
        setTimeView.isHidden = true
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
    ///是否审核通过点击
    @IBAction func passBtnClick(_ sender: UIButton) {
        if sender == noPassBtn {
            
            noPassBtn.backgroundColor = kMainColor
            noPassBtn.setTitleColor(UIColor.white, for: .normal)
            noPassBtn.layer.borderWidth = 0
            
            passBtn.layer.borderWidth = 1
            passBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            passBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            passBtn.backgroundColor = UIColor.white
            
            uploadImgBtn.isHidden = true
            setTimeView.isHidden = true
            reasonTV.isHidden = false
        }
        if sender == passBtn {
            
            passBtn.backgroundColor = kMainColor
            passBtn.setTitleColor(UIColor.white, for: .normal)
            passBtn.layer.borderWidth = 0
            
            noPassBtn.layer.borderWidth = 1
            noPassBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            noPassBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            noPassBtn.backgroundColor = UIColor.white
            
            uploadImgBtn.isHidden = false
            setTimeView.isHidden = false
            reasonTV.isHidden = true
        }
    }
    
    ///上传图片
    @IBAction func uploadImgBtnClick(_ sender: UIButton) {
        
    }
    
    ///设置时间
    @IBAction func setTimeBtnClick(_ sender: UIButton) {
        
    }
    ///确认按钮
    @IBAction func commitBtnClick(_ sender: AnimatableButton) {
        let vc = ManagerBillApprovalFourViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
