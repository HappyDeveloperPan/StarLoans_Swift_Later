//
//  ManagerBillDisposeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/8.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ManagerBillApprovalViewController: BaseViewController, StoryboardLoadable {
    @IBOutlet weak var leftDisposeBtn: UIButton!
    @IBOutlet weak var rightDisposeBtn: UIButton!
    @IBOutlet weak var textView: MyTextView!
    @IBOutlet weak var uploadView: UIView!
    
    //MARK: - 可操作数据
    var btnArr =  [UIButton]()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待审批"
        setupBasic()
    }
    
    func setupBasic() {
        leftDisposeBtn.layer.cornerRadius = leftDisposeBtn.height/2
        leftDisposeBtn.layer.borderWidth = 1
        leftDisposeBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
        leftDisposeBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
        
        rightDisposeBtn.layer.cornerRadius = rightDisposeBtn.height/2
        rightDisposeBtn.backgroundColor = kMainColor
        rightDisposeBtn.setTitleColor(UIColor.white, for: .normal)
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.RGB(with: 198, green: 198, blue: 198).cgColor
        textView.layer.cornerRadius = 5
        textView.placeholder = "请输入不通过原因"
        
//        uploadView.isHidden = true
        textView.isHidden = true
        btnArr.append(leftDisposeBtn)
        btnArr.append(rightDisposeBtn)
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

    @IBAction func disposeBtnClick(_ sender: UIButton) {
//        for btn in btnArr {
//            if btn == sender {
//                btn.isSelected = true
//            }else {
//                btn.isSelected = false
//            }
//        }
        if sender == leftDisposeBtn {
            rightDisposeBtn.layer.cornerRadius = leftDisposeBtn.height/2
            rightDisposeBtn.layer.borderWidth = 1
            rightDisposeBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            rightDisposeBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            rightDisposeBtn.backgroundColor = UIColor.white
            
            leftDisposeBtn.layer.cornerRadius = rightDisposeBtn.height/2
            leftDisposeBtn.backgroundColor = kMainColor
            leftDisposeBtn.setTitleColor(UIColor.white, for: .normal)
            leftDisposeBtn.layer.borderWidth = 0
            
            textView.isHidden = false
            uploadView.isHidden = true
        }
        if sender == rightDisposeBtn {
            leftDisposeBtn.layer.cornerRadius = leftDisposeBtn.height/2
            leftDisposeBtn.layer.borderWidth = 1
            leftDisposeBtn.layer.borderColor = UIColor.RGB(with: 153, green: 153, blue: 153).cgColor
            leftDisposeBtn.setTitleColor(UIColor.RGB(with: 153, green: 153, blue: 153), for: .normal)
            leftDisposeBtn.backgroundColor = UIColor.white
            
            rightDisposeBtn.layer.cornerRadius = rightDisposeBtn.height/2
            rightDisposeBtn.backgroundColor = kMainColor
            rightDisposeBtn.setTitleColor(UIColor.white, for: .normal)
            rightDisposeBtn.layer.borderWidth = 0
            
            textView.isHidden = true
            uploadView.isHidden = false
        }
    }
}
