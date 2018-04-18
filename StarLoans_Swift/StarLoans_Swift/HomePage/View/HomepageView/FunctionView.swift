//
//  FunctionView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/30.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

@objc protocol FunctionViewDelegate {
    func buttonDidSelect(at index: Int)
}

//MARK: - 功能栏
class FunctionView: UIView {

    weak var delegate:FunctionViewDelegate?
    var buttonArr = [FuncButton]()
    
    // MARK: - 懒加载
    lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
        }()
    
    // MARK: - 内部属性
//    fileprivate let imagesArr: [UIImage] = [#imageLiteral(resourceName: "ICON-products"), #imageLiteral(resourceName: "ICON-college"), #imageLiteral(resourceName: "ICON-video-1"), #imageLiteral(resourceName: "ICON-information")]
//    fileprivate let titleArr: [String] = ["热门产品", "贷款学院", "视频中心", "资讯研读"]
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 设置功能按钮
    ///
    /// - Parameters:
    ///   - imagesArr: <#imagesArr description#>
    ///   - titleArr: <#titleArr description#>
    func setFuncBtn(_ imagesArr: [UIImage], titleArr: [String]) {
        for i in 0..<titleArr.count {
            let button = FuncButton()
            button.tag = i + 1
            button.setTitle(titleArr[i], for: .normal)
            button.setImage(imagesArr[i], for: .normal)
            button.addTarget(self, action: #selector(funcBtnClick(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    func setFuncBtn(_ imgArr: [UIImage], selectImgArr: [UIImage]?, titleArr: [String], norColor: UIColor, selectColor: UIColor?) {
        for i in 0..<titleArr.count {
            let button = FuncButton()
            button.tag = i + 1
            button.setTitle(titleArr[i], for: .normal)
            button.setTitleColor(norColor, for: .normal)
            button.setTitleColor(selectColor ?? norColor, for: .selected)
            button.setImage(imgArr[i], for: .normal)
            button.setImage((selectImgArr ?? imgArr)[i], for: .selected)
            button.addTarget(self, action: #selector(funcBtnClick(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttonArr.append(button)
        }
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        stackView.layoutIfNeeded()
    }
    
    
    /// 按钮点击事件
    ///
    /// - Parameter button: 被点击的按钮
    @objc func funcBtnClick(_ sender: UIButton) {
//        print("第\(button.tag)个按钮被点击了")
        for button in buttonArr {
            if button == sender {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
        }
        delegate?.buttonDidSelect(at: sender.tag-1)
    }
    
    func selectedBtnIndex(_ index: Int) {
        for button in buttonArr {
            if button == buttonArr[index] {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
        }
    }
}

//MARK: - 自定义功能按钮
class FuncButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置按钮的基本属性
    func commonInit() {
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setTitleColor(UIColor.RGB(with: 51, green: 51, blue: 51), for: .normal)
    }
    
    //调整系统UIButton的文字的位置
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX = 0
        let titleY = contentRect.size.height * 0.5
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height - titleY
        return CGRect(x: CGFloat(titleX), y: titleY, width: titleW, height: titleH)
    }
    
    //调整系统UIButton的图片的位置
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.size.width
        let imageH = contentRect.size.height
        return CGRect(x: 0, y: 13.5, width: imageW, height: 30)
    }
}
