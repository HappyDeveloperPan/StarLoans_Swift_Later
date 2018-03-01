//
//  InformationView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/8.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class InformationView: UIView {
    
    lazy var leftImg: UIImageView = { [unowned self] in
        let leftImg = UIImageView()
        addSubview(leftImg)
        leftImg.image = #imageLiteral(resourceName: "ICON-GONGGAO")
        return leftImg
    }()
    
    lazy var contentLB: UILabel = { [unowned self] in
        let contentLB = UILabel()
        addSubview(contentLB)
        contentLB.text = "新消息显示位置新消息显示位置新消息显示位置"
        contentLB.textColor = UIColor.RGB(with: 51, green: 51, blue: 51)
        contentLB.font = UIFont.systemFont(ofSize: 12)
        return contentLB
    }()
    
    lazy var gotoBtn: UIButton = { [unowned self] in
        let gotoBtn = UIButton()
        addSubview(gotoBtn)
        gotoBtn.setTitle(">", for: .normal)
        gotoBtn.setTitleColor(kTitleColor, for: .normal)
        gotoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        gotoBtn.addTarget(self, action: #selector(gotoBtnClick(_:)), for: .touchUpInside)
        return gotoBtn
    }()

    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 17.5, height: 16))
        }
        
        contentLB.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(8)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(gotoBtn.snp.left).offset(-8)
        }
        
        gotoBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
    }
    
    @objc func gotoBtnClick(_ sender: UIButton) {
        print("消息栏被点击了")
    }
}
