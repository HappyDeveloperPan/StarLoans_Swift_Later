//
//  ResetViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

enum ResetType {
    case newPhoneNum                //新手机号
    case verCode                    //验证码
    case transactionPass            //交易密码
    case confirmTransactionPass     //确认交易密码
    case oldLoginPass               //原密码
    case newLoginPass               //新密码
    case confirmNewLoginPass        //确认新密码
}

class ResetViewController: BaseViewController, StoryboardLoadable{
    //MARK: - Storyboard连线
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var importView: LoginInputView!
    @IBOutlet weak var explainLB: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - 外部属性
    var resetType: ResetType = .newPhoneNum
    var userModel = UserModel()
    var phoneNumber: String = ""
    var transactionPass: String = ""
    var oldLoginPass: String = ""
    var loginPass: String = ""
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        setBasicData()
    }
    
    func setupBasic() {
        switch resetType {
        case .newPhoneNum:
            title = "输入新手机号"
            titleLB.text = "输入新手机号"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-phone-1")
            importView.selectImage = #imageLiteral(resourceName: "ICON-phone")
            importView.textField.placeholder = "请输入手机号"
            importView.textField.keyboardType = .numberPad
            importView.textLength = 11
        case .verCode:
            title = "输入验证码"
            titleLB.text = "输入验证码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入验证码"
            importView.textField.keyboardType = .numberPad
            importView.rightImage = .none
            nextBtn.setTitle("提交", for: .normal)
        case .transactionPass:
            title = "输入交易密码"
            titleLB.text = "输入交易密码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入密码"
            importView.textField.isSecureTextEntry = true
            importView.rightImage = .eye
        case .confirmTransactionPass:
            title = "确认交易密码"
            titleLB.text = "确认交易密码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入密码"
            importView.textField.isSecureTextEntry = true
            importView.rightImage = .eye
            nextBtn.setTitle("提交", for: .normal)
        case .oldLoginPass:
            title = "输入原登录密码"
            titleLB.text = "输入原登录密码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入密码"
            importView.textField.isSecureTextEntry = true
            importView.rightImage = .eye
        case .newLoginPass:
            title = "设置新密码"
            titleLB.text = "设置新密码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入密码"
            importView.textField.isSecureTextEntry = true
            importView.rightImage = .eye
        case .confirmNewLoginPass:
            title = "确认新密码"
            titleLB.text = "确认新密码"
            importView.leftImageView.image = #imageLiteral(resourceName: "ICON-mima")
            importView.selectImage = #imageLiteral(resourceName: "ICON-mima-1")
            importView.textField.placeholder = "请输入密码"
            importView.textField.isSecureTextEntry = true
            importView.rightImage = .eye
            nextBtn.setTitle("提交", for: .normal)
        }
        nextBtn.layer.cornerRadius = nextBtn.height/2
    }
    
    func setBasicData() {
        if resetType == .verCode {
            getVercode()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 控件点击事件
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        switch resetType {
        case .newPhoneNum:
            guard (importView.textField.text?.judgeMobileNumber())! else {
                JSProgress.showFailStatus(with: "请输入正确的手机号")
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .verCode
            vc.phoneNumber = importView.textField.text!
            navigationController?.pushViewController(vc, animated: true)
        case .verCode:
            guard judgeVerCode() else {
                JSProgress.showFailStatus(with: "请输入正确验证码")
                return
            }
            modifyPhoneNumber()
        case .transactionPass:
            guard !((importView.textField.text?.isEmpty)!) else {
                JSProgress.showFailStatus(with: "请输入密码")
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .confirmTransactionPass
            vc.transactionPass = importView.textField.text!
            navigationController?.pushViewController(vc, animated: true)
        case .confirmTransactionPass:
            guard judgeTransactionPass() else {
                JSProgress.showFailStatus(with: "两次密码输入不一致")
                return
            }
            setTransactionPass()
//            JSProgress.showSucessStatus(with: "修改成功")
//            //跳转回设置界面并且刷新
//            for controller: UIViewController in (navigationController?.viewControllers)! {
//                if (controller is SettingViewController) {
//                    let revise = controller as? SettingViewController
//                    navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
//                }
//            }
        case .oldLoginPass:
            guard !((importView.textField.text?.isEmpty)!) else {
                JSProgress.showFailStatus(with: "请输入旧密码")
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .newLoginPass
            vc.oldLoginPass = importView.textField.text!
            navigationController?.pushViewController(vc, animated: true)
        case .newLoginPass:
            guard !((importView.textField.text?.isEmpty)!) else {
                JSProgress.showFailStatus(with: "请输入新密码")
                return
            }
            let vc = ResetViewController.loadStoryboard()
            vc.resetType = .confirmNewLoginPass
            vc.oldLoginPass = oldLoginPass
            vc.loginPass = importView.textField.text!
            navigationController?.pushViewController(vc, animated: true)
        case .confirmNewLoginPass:
            guard judgeLoginPass() else {
                JSProgress.showFailStatus(with: "两次密码输入不一致")
                return
            }
            resetLoginPass()
//            JSProgress.showSucessStatus(with: "修改成功")
//            //跳转回设置界面并且刷新
//            for controller: UIViewController in (navigationController?.viewControllers)! {
//                if (controller is SettingViewController) {
//                    let revise = controller as? SettingViewController
//                    navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
//                }
//            }
        }
    }
    
}

//MARK: - 数据处理
extension ResetViewController {
    ///判断验证码是否输入正确
    func judgeVerCode() -> Bool {
        return (importView.textField.text == userModel.yzm) ? true : false
    }
    
    ///判断交易密码是否一致
    func judgeTransactionPass() -> Bool {
        return (importView.textField.text == transactionPass) ? true : false
    }
    
    ///判断登录密码是否一致
    func judgeLoginPass() -> Bool {
        return (importView.textField.text == loginPass) ? true : false
    }
    
    ///获取验证码
    func getVercode() {
        var parameters = [String: Any]()
        parameters["user"] = phoneNumber
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
    
    ///修改手机号
    func modifyPhoneNumber() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["phone"] = phoneNumber
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_ChangePhone, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                JSProgress.showSucessStatus(with: "修改成功")
                //跳转回设置界面并且刷新
                for controller: UIViewController in (self?.navigationController?.viewControllers)! {
                    if (controller is SettingViewController) {
                        let revise = controller as? SettingViewController
                        self?.navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
                    }
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
    
    ///设置交易密码
    func setTransactionPass() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["pwd"] = importView.textField.text?.md5
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_SetDealPWD, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                JSProgress.showSucessStatus(with: "设置成功")
                //跳转回设置界面并且刷新
                for controller: UIViewController in (self?.navigationController?.viewControllers)! {
                    if (controller is SettingViewController) {
                        let revise = controller as? SettingViewController
                        self?.navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
                    }
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
    
    ///修改登录密码
    func resetLoginPass() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["old_pwd"] = oldLoginPass.md5
        parameters["pwd"] = importView.textField.text?.md5
        
        JSProgress.hidden()
        
        NetWorksManager.requst(with: kUrl_ResetLoginPass, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                JSProgress.showSucessStatus(with: "设置成功")
                //跳转回设置界面并且刷新
                for controller: UIViewController in (self?.navigationController?.viewControllers)! {
                    if (controller is SettingViewController) {
                        let revise = controller as? SettingViewController
                        self?.navigationController?.popToViewController(revise ?? UIViewController(), animated: true)
                    }
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
}
