//
//  LoginInputView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/25.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

enum rightImage {
    case none   //默认
    case verCode    //验证码
    case eye    //隐藏显示密码
}

protocol LoginInputViewDelegate: class{
    func verCodeBtnClick(clickHandler: (_ isPhone: Bool)->())
}

//MARK: - 自定义输入框
class LoginInputView: UIView {
    
    weak var delegate: LoginInputViewDelegate?
    
    var textLength : Int = 0
    var image : UIImage?
    var selectImage : UIImage?
    var rightImage : rightImage = .none 
    var isShowPwd : Bool = false
    
    //MARK: - 控件懒加载
    lazy var leftImageView: UIImageView = { [unowned self] in
        let leftImageView = UIImageView()
        self.addSubview(leftImageView)
        return leftImageView
        }()
    
    lazy var textField: UITextField = { [unowned self] in
        let textField = UITextField()
        self.addSubview(textField)
        textField.textColor = UIColor.gray
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.tintColor = kMainColor
        return textField
    }()
    
    lazy var bottomLine: UIView = { [unowned self] in
        let bottomLine = UIView()
        self.addSubview(bottomLine)
        bottomLine.backgroundColor = kLineColor
        return bottomLine
    }()
    
    lazy var verCodeBtn: VerCodeButton = { [unowned self] in
        let verCodeBtn = VerCodeButton()
        self.addSubview(verCodeBtn)
        verCodeBtn.delegate = self
        return verCodeBtn
    }()
    
    lazy var eyeBtn: UIButton = { [unowned self] in
        let eyeBtn = UIButton()
        self.addSubview(eyeBtn)
        eyeBtn.setImage(#imageLiteral(resourceName: "ICON-xianshimima"), for: .normal)
        eyeBtn.setImage(#imageLiteral(resourceName: "ICON-yincangmima"), for: .selected)
        eyeBtn.addTarget(self, action: #selector(showHiddenPassword(_:)), for: .touchUpInside)
        return eyeBtn
    }()
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.width.equalTo(14)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
        
        switch rightImage {
        case .verCode:
            verCodeBtn.snp.makeConstraints { (make) in
                make.right.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 80, height: 30))
            }
            textField.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalTo(bottomLine.snp.top)
                make.right.equalTo(verCodeBtn.snp.left)
                make.left.equalTo(leftImageView.snp.right).offset(10)
            }
        case .eye:
            eyeBtn.snp.makeConstraints { (make) in
                make.right.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 21, height: 13))
            }
            textField.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalTo(bottomLine.snp.top)
                make.right.equalTo(eyeBtn.snp.left)
                make.left.equalTo(leftImageView.snp.right).offset(10)
            }
        default:
            textField.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalTo(bottomLine.snp.top)
                make.right.right.equalToSuperview()
                make.left.equalTo(leftImageView.snp.right).offset(10)
            }
        }
        
    }
    
    //监听textField值的变化
    @objc func textFieldDidChange(_ textField: UITextField) {
//        if textField == textField && textLength > 0{
//            if (textField.text?.lengthOfBytes(using: .utf8))! > textLength {
//                textField.text = (textField.text as NSString?)?.substring(to: textLength)
//            }
//        }
        
        if textField == textField && textLength > 0 && (textField.text?.lengthOfBytes(using: .utf8))! > textLength {
            textField.text = (textField.text as NSString?)?.substring(to: textLength)
        }
    }
    
    //隐藏显示密码
    @objc func showHiddenPassword(_ button: UIButton) {
        textField.isSecureTextEntry = button.isSelected
        button.isSelected = !button.isSelected
    }
    
}

extension LoginInputView: VerCodeButtonDelegate {
    func verCodeBtnClick(clickHandler: (Bool) -> ()) {
        delegate?.verCodeBtnClick(clickHandler: { (isPhone) in
            clickHandler(isPhone)
        })
    }
    
//    func verCodeBtnClick() {
//        delegate?.verCodeBtnClick()
//    }
}

//MARK: - textfield代理
extension LoginInputView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bottomLine.backgroundColor = kMainColor
        image = leftImageView.image
        leftImageView.image = selectImage
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        bottomLine.backgroundColor = kLineColor
        leftImageView.image = image
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.lengthOfBytes(using: .utf8))! > textLength && textLength > 0{
            return false
        }
        return true
    }
}

protocol VerCodeButtonDelegate: class{
    func verCodeBtnClick(clickHandler: (_ isPhone: Bool)->())
}

//MARK: - 验证码按钮
class VerCodeButton: UIButton {
    
    weak var delegate: VerCodeButtonDelegate?
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super .init(frame: frame)
        setTitle("获取验证码", for: .normal)
        setTitleColor(kMainColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = kMainColor.cgColor
        titleLabel?.adjustsFontSizeToFitWidth = true
        addTarget(self, action: #selector(VerCodeButton.sendButtonClick(_:)), for: .touchUpInside)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//        setTitle("获取验证码", for: .normal)
//        setTitleColor(kTextColor, for: .normal)
//        titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        layer.cornerRadius = 15
//        layer.borderWidth = 0.5
//        layer.borderColor = kMainColor.cgColor
        titleLabel?.adjustsFontSizeToFitWidth = true
        addTarget(self, action: #selector(VerCodeButton.sendButtonClick(_:)), for: .touchUpInside)
    }
    
    class func verCodeButton() -> VerCodeButton {
        return Bundle.main.loadNibNamed(NSStringFromClass(self), owner: nil, options: nil)?.first as! VerCodeButton
    }
    
    //MARK: - 倒计时属性
    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            setTitle("已发送(\(newValue)s)", for: .normal)
            if newValue <= 0 {
                setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 5
                setTitleColor(kTextColor, for: .normal)
                layer.borderColor = kTextColor.cgColor
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                setTitleColor(kMainColor, for: .normal)
                layer.borderColor = kMainColor.cgColor
            }
            isEnabled = !newValue
        }
    }
}

extension VerCodeButton {
    @objc func sendButtonClick(_ sender: UIButton) {
        delegate?.verCodeBtnClick(clickHandler: { (isPhone) in
            guard isPhone else {
                return
            }
            isCounting = true
        })
        
//        isCounting = true
    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
}
