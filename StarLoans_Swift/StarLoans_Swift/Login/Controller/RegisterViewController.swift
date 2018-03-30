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
    lazy var mainView: UIScrollView = { [unowned self] in
        let mainView = UIScrollView()
        self.view.addSubview(mainView)
        mainView.showsVerticalScrollIndicator = false
        mainView.showsHorizontalScrollIndicator = false
        return mainView
    }()
    
    lazy var logoImg: UIImageView = { [unowned self] in
        let logoImg = UIImageView()
        self.mainView.addSubview(logoImg)
        logoImg.image = #imageLiteral(resourceName: "Login-Logo-3")
        logoImg.contentMode = .scaleAspectFit
        return logoImg
    }()
    
    lazy var nameView: LoginInputView = { [unowned self] in
        let nameView = LoginInputView()
        self.mainView.addSubview(nameView)
        nameView.leftImageView.image = #imageLiteral(resourceName: "ICON-mine")
        nameView.selectImage = #imageLiteral(resourceName: "ICON-mine-select")
        nameView.textField.placeholder = "请输入真实姓名"
        nameView.textLength = 11
        return nameView
    }()
    
    lazy var phoneView: LoginInputView = { [unowned self] in
        let phoneView = LoginInputView()
        self.mainView.addSubview(phoneView)
        phoneView.leftImageView.image = #imageLiteral(resourceName: "ICON-phone-1")
        phoneView.selectImage = #imageLiteral(resourceName: "ICON-phone")
        phoneView.textField.placeholder = "请输入手机号"
        phoneView.textField.keyboardType = .numberPad
        phoneView.textLength = 11
        return phoneView
        }()
    
    lazy var verCodeView: LoginInputView = { [unowned self] in
        let verCodeView = LoginInputView()
        self.mainView.addSubview(verCodeView)
        verCodeView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
        verCodeView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
        verCodeView.textField.placeholder = "请输入验证码"
        verCodeView.textField.keyboardType = .numberPad
        verCodeView.rightImage = .verCode
        verCodeView.textLength = 6
        verCodeView.delegate = self
        return verCodeView
        }()
    
    lazy var pwdView: LoginInputView = { [unowned self] in
        let pwdView = LoginInputView()
        self.mainView.addSubview(pwdView)
        pwdView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
        pwdView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
        pwdView.textField.placeholder = "请设置密码"
        pwdView.textField.isSecureTextEntry = true
        pwdView.rightImage = .eye
        pwdView.textLength = 16
        return pwdView
        }()
    
    lazy var commitBtn: UIButton = { [unowned self] in
        let commitBtn = UIButton()
        self.mainView.addSubview(commitBtn)
        commitBtn.backgroundColor = kMainColor
        commitBtn.setTitle("确认", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.layer.cornerRadius = 22.5
        commitBtn.addTarget(self, action: #selector(commitBtnClick(_:)), for: .touchUpInside)
        return commitBtn
        }()
    
    //MARK: - 内部属性
    private let kBoard: CGFloat = 37.5
    private let kHeight: CGFloat = 50.0
    fileprivate var userModel = UserModel()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        mainView.layoutIfNeeded()
        //Logo
        logoImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kHeight))
            make.right.equalToSuperview()
            make.top.equalTo(10)
        }
        logoImg.layoutIfNeeded()
        //真实姓名
        nameView.snp.makeConstraints { (make) in
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
            make.top.equalTo(logoImg.snp.bottom).offset(50)
        }
        //手机号
        phoneView.snp.makeConstraints { (make) in
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
            make.top.equalTo(nameView.snp.bottom)
        }
        //验证码
        verCodeView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        //密码
        pwdView.snp.makeConstraints { (make) in
            make.top.equalTo(verCodeView.snp.bottom)
            make.left.equalTo(kBoard)
            make.right.equalTo(-kBoard)
            make.height.equalTo(kHeight)
        }
        //提交
        commitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwdView.snp.bottom).offset(kBoard)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(45)
            make.bottom.equalTo(-20)
        }
    }
    
    deinit {
        print("页面被销毁了")
    }
}

//MARK: - 数据处理
extension RegisterViewController {
    /// 获取验证码
    func getVercode() {
        let parameters = ["user": phoneView.textField.text!]
        
        NetWorksManager.requst(with: kUrl_GetCode, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    self?.userModel = UserModel(with: data)
                }
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
    
    /// 注册按钮点击事件
    ///
    /// - Parameter sender: 注册按钮
    @objc func commitBtnClick(_ sender: UIButton) {
//        let vc = ApproveSelectViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        guard (nameView.textField.text?.count)! > 0 else {
            JSProgress.showFailStatus(with: "请填写真实姓名")
            return
        }
        guard (phoneView.textField.text?.count)! > 0 else {
            JSProgress.showFailStatus(with: "请填写手机号")
            return
        }
        guard (verCodeView.textField.text?.count)! > 0 else {
            JSProgress.showFailStatus(with: "请填写验证码")
            return
        }
        guard (pwdView.textField.text?.count)! > 0 else {
            JSProgress.showFailStatus(with: "请填写密码")
            return
        }
        userRegister()
    }
    
    /// 用户注册
    func userRegister() {
        var parameters = [String: Any]()
        parameters["user"] = nameView.textField.text
        parameters["phone"] = phoneView.textField.text
        parameters["yzm"] = verCodeView.textField.text
        parameters["pass"] = pwdView.textField.text?.md5
        parameters["token"] = userModel.token
        parameters["platform"] = "ios"
        parameters["registration"] = Utils.getAsynchronousWithKey(kRegistrationID)
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_Register, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
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
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
                let vc = ApproveSelectViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
                //暂时注释掉
                //                    self?.navigationController?.dismiss(animated: true, completion: nil)
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

//MARK: - LoginInputView代理
extension RegisterViewController: LoginInputViewDelegate {
    /// 验证码按钮点击事件
    ///
    /// - Parameter clickHandler: 根据是否是手机号回调来判断是否可以获取验证码
    func verCodeBtnClick(clickHandler: (Bool) -> ()) {
        guard (phoneView.textField.text?.judgeMobileNumber())! else {
            JSProgress.showFailStatus(with: "请输入正确的手机号")
            return
        }
        clickHandler(true)
        getVercode()
    }
}
