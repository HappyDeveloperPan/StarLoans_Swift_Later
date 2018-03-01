//
//  VerifyViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/25.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

enum vcType {
    case register
    case forgetPassword
}

private let kBoard = 37.5
private let kHeight = 45

class VerifyViewController: UIViewController {
    
    var vcType : vcType = .register
    var userModel: UserModel = UserModel()

    //MARK: - 懒加载
    lazy var phoneView: LoginInputView = { [unowned self] in
        let phoneView = LoginInputView()
        self.view.addSubview(phoneView)
        phoneView.leftImageView.image = #imageLiteral(resourceName: "ICON-phone-1")
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
        verCodeView.delegate = self
        verCodeView.textLength = 6
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
        view.backgroundColor = UIColor.white
        switch vcType {
        case .register:
            title = "注册"
        case .forgetPassword:
            title = "找回密码"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        //手机号
        phoneView.snp.makeConstraints { (make) in
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
            make.top.equalTo(kBoard)
        }
        
        //验证码
        verCodeView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(kBoard/2)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        
        //下一步
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(verCodeView.snp.bottom).offset(kBoard)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(45)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

}

//MARK: - 数据处理
extension VerifyViewController {
    @objc func settingPasswordVc() {
        
        guard phoneView.textField.text?.lengthOfBytes(using: .utf8) != 0 else {
            JSProgress.showFailStatus(with: "请输入手机号")
            return
        }
        guard verCodeView.textField.text?.lengthOfBytes(using: .utf8) != 0 else {
            JSProgress.showFailStatus(with: "请输入验证码")
            return
        }
        
        guard judgeVerCode() else {
            JSProgress.showFailStatus(with: "验证码错误")
            return
        }
        
        let passwordVc = PasswordViewController()
        passwordVc.vcType = vcType
        passwordVc.userModel = userModel
        passwordVc.user = phoneView.textField.text!
        navigationController?.pushViewController(passwordVc, animated: true)
        
    }
    
    ///判断验证码是否输入正确
    func judgeVerCode() -> Bool {
        return (verCodeView.textField.text == userModel.yzm) ? true : false
    }
}

extension VerifyViewController: LoginInputViewDelegate {
    ///获取验证码
    func verCodeBtnClick(clickHandler: (Bool) -> ()) {
        guard (phoneView.textField.text?.judgeMobileNumber())! else {
            JSProgress.showFailStatus(with: "请输入正确的手机号")
            return
        }
        clickHandler(true)
        
        let parameters = ["user": phoneView.textField.text!]
        
        NetWorksManager.requst(with: kUrl_GetCode, type: .post, parameters: parameters) { [weak self] (jsonData, error) in

            if jsonData?["status"] == 200 {
                self?.userModel = UserModel(with: (jsonData?["data"])!)
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }

}
