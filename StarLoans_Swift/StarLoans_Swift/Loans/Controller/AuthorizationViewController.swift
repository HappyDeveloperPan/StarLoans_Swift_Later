//
//  AuthorizationViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

///贷款客户类别
enum LoanClientType: Int {
    case personage = 0 //个人
    case company = 1   //企业
}

class AuthorizationViewController: BaseViewController, StoryboardLoadable {
    //MARK: - storyboard连线
    @IBOutlet weak var flowTwoLB: UILabel!
    @IBOutlet weak var leftLine: UIImageView!
    @IBOutlet weak var rightLine: UIImageView!
    @IBOutlet weak var privacyContentLB: UILabel!
    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet weak var hintContentLB: UILabel!
    
    //MARK: - 对外属性
    var productId: Int = 0
    var loansProductType: LoansProductType = .selfSupport //产品类别
    var loanClientType: LoanClientType = .personage //用户类别
    var url: String = ""
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
    }
    
    func setupBasic() {
        title = "授权确认"
        view.backgroundColor = kHomeBackColor
        
        if loanClientType == .personage {
            title = "客户信息录入"
        }else {
            title = "企业信息录入"
        }
        
        leftLine.drawImaginaryLine(with: UIColor.RGB(with: 210, green: 210, blue: 210))
        rightLine.drawImaginaryLine(with: UIColor.RGB(with: 210, green: 210, blue: 210))
        
        privacyContentLB.sizeToFit()
        privacyContentLB.numberOfLines = 0
        privacyContentLB.text = "为了确保客户的切身利益，我们将向客户发送一条短信，告知用户您正在为其办理贷款业务；请准确录入客户信息，以便系统核对。"
        
        commitBtn.layer.cornerRadius = commitBtn.height/2
        
        hintContentLB.sizeToFit()
        hintContentLB.numberOfLines = 0
        hintContentLB.text = "温馨提示：为了让有需求的经纪人能更精准的匹配，请您录入真实的客户信息，在未产生交易前，我们不会对经纪人开放客户隐私信息，同时我们将对客户信息全方位保密。"
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

    @IBAction func commitBtnClick(_ sender: UIButton) {
        //跳转到录入信息界面
        if loansProductType == .thirdSupport {
            let vc = InputUserInfoViewController.loadStoryboard()
            vc.productId = productId
            vc.loansProductType = loansProductType
            vc.loanClientType = loanClientType
            navigationController?.pushViewController(vc, animated: true)
        }else {
            //自营产品需要跳转网页
            let vc = InputUserInfoWebViewController()
            vc.productId = productId
            vc.url = url
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
