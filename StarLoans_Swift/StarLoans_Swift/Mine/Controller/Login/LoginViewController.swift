//
//  LoginViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON

private let kBoard = 37.5
private let kHeight = 45

// MARK: - 界面部分
class LoginViewController: BaseViewController {
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = ""
//        setNavigationBarConfig()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(callback))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: registerBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillLayoutSubviews() {
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 顶部标题
    lazy var logoImg: UIImageView = { [unowned self] in
        let logoImg = UIImageView()
        self.view.addSubview(logoImg)
        logoImg.image = #imageLiteral(resourceName: "Login-Logo-3")
        return logoImg
    }()
    
    lazy var topLab: UILabel = { [unowned self] in
        let topLab = UILabel()
        self.view.addSubview(topLab)
        topLab.text = "欢迎您!"
        topLab.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return topLab
        }()
    
    //MARK: - 手机号
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
    
    //MARK: - 密码
    lazy var pwdView: LoginInputView = { [unowned self] in
        let pwdView = LoginInputView()
        self.view.addSubview(pwdView)
        pwdView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
        pwdView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
        pwdView.textField.placeholder = "请输入密码"
        pwdView.textField.isSecureTextEntry = true
        pwdView.textLength = 16
        return pwdView
    }()
    
    //MARK: - 登录, 注册, 忘记密码
    lazy var loginBtn: UIButton = { [unowned self] in
        let loginBtn = UIButton()
        self.view.addSubview(loginBtn)
        loginBtn.backgroundColor = kMainColor
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.layer.cornerRadius = 22.5
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        return loginBtn
    }()
    
    lazy var forgetBtn: UIButton = { [unowned self] in
        let forgetBtn = UIButton()
        self.view.addSubview(forgetBtn)
        forgetBtn.setTitle("忘记密码?", for: .normal)
        forgetBtn.setTitleColor(kTextColor, for: .normal)
        forgetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        forgetBtn.addTarget(self, action: #selector(forgetVc), for: .touchUpInside)
        return forgetBtn
    }()
    
    lazy var registerBtn: UIButton = { [unowned self] in
        let registerBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.setTitleColor(kMainColor, for: .normal)
        registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registerBtn.addTarget(self, action: #selector(registerVc), for: .touchUpInside)
        return registerBtn
    }()
    
    func setupUI() {
        logoImg.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(36)
        }
        
        //顶部标题
        topLab.snp.makeConstraints { (make) in
            make.top.equalTo(logoImg.snp.bottom).offset(24)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        
        //手机号
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(topLab.snp.bottom).offset(kBoard/2)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        
        //密码
        pwdView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(kBoard/2)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        
        //忘记密码
        forgetBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwdView.snp.bottom).offset(kBoard/2)
            make.width.equalTo(80)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        
        //登录
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(forgetBtn.snp.bottom).offset(kBoard/2)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(45)
        }

    }
}

//MARK: - 数据处理部分
extension LoginViewController {
    
    ///用户登录
    @objc func login() {
        
        guard phoneView.textField.text?.lengthOfBytes(using: .utf8) != 0 else {
            JSProgress.showFailStatus(with: "请输入手机号")
            return
        }
        guard pwdView.textField.text?.lengthOfBytes(using: .utf8) != 0 else {
            JSProgress.showFailStatus(with: "请输入密码")
            return
        }
//        let parameters = ["user": phoneView.textField.text!,
//                          "pass": pwdView.textField.text!.md5,] as [String : Any]
        var parameters = [String: Any]()
        parameters["user"] = phoneView.textField.text
        parameters["pass"] = pwdView.textField.text?.md5
        parameters["platform"] = "ios"
        parameters["registration"] = Utils.getAsynchronousWithKey(kRegistrationID)
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_Login, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    let userModel = UserModel(with: data)
                    UserManager.shareManager.userModel = userModel
                    UserManager.shareManager.isLogin = true
                    var userDic = [String: Any]()
                    userDic["token"] = userModel.token
                    userDic["is_audit"] = userModel.is_audit
                    userDic["tx"] = userModel.tx
                    userDic["type"] = userModel.type
                    userDic["user"] = userModel.user
                    Utils.setAsynchronous(userDic, withKey: kSavedUser)
                }
//                UserManager.shareManager.userModel = UserModel(with: (jsonData?["data"])!)
//                UserManager.shareManager.isLogin = true
//                if let userDic = jsonData?["data"].dictionaryObject {
//                    Utils.setAsynchronous(userDic, withKey: kSavedUser)
//                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
                self?.navigationController?.dismiss(animated: true, completion: nil)
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
    
    @objc func callback() {
        navigationController?.dismiss(animated: true, completion: {
        })
    }
    
    @objc func forgetVc() {
        let forgetVc = VerifyViewController()
        forgetVc.vcType = .forgetPassword
        navigationController?.pushViewController(forgetVc, animated: true)
    }
    
    @objc func registerVc() {
        let registerVc = VerifyViewController()
        registerVc.vcType = .register
        navigationController?.pushViewController(registerVc, animated: true)
    }
}
