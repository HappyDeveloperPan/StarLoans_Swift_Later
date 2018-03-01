//
//  RegisterViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/21.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - 懒加载
    lazy var phoneView: LoginInputView = { [unowned self] in
        let phoneView = LoginInputView()
        self.view.addSubview(phoneView)
        phoneView.leftImageView.image = #imageLiteral(resourceName: "ICON-phone")
        phoneView.selectImage = #imageLiteral(resourceName: "ICON-phone")
        phoneView.textField.placeholder = "请输入手机号"
        phoneView.textField.keyboardType = .numberPad
        phoneView.textLength = 11
        return phoneView
        }()
    
    lazy var verCodeView: LoginInputView = { [unowned self] in
        let verCodeView = LoginInputView()
        self.view.addSubview(verCodeView)
        verCodeView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
        verCodeView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
        verCodeView.textField.placeholder = "请输入验证码"
        verCodeView.textField.keyboardType = .numberPad
        verCodeView.rightImage = .verCode
        return verCodeView
        }()
    
    lazy var nextBtn: UIButton = { [unowned self] in
        let nextBtn = UIButton()
        self.view.addSubview(nextBtn)
        nextBtn.backgroundColor = kMainColor
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(settingPasswordVc), for: .touchUpInside)
        return nextBtn
        }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
    }
}

extension RegisterViewController {
    @objc func settingPasswordVc() {
        //跳转到设置密码界面
    }
}
