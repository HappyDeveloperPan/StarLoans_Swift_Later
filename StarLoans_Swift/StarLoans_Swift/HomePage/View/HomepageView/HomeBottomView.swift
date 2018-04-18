//
//  HomeBottomView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/17.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class HomeBottomView: UIView {
    // MARK: - 懒加载
    lazy var label: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.RGB(with: 204, green: 204, blue: 204)
        label.text = "我是有底线的!"
        return label
    }()
    
    lazy var leftView: UIView = {
        let leftView = UIView()
        self.addSubview(leftView)
        leftView.backgroundColor = UIColor.RGB(with: 229, green: 229, blue: 229)
        return leftView
    }()
    
    lazy var rightView: UIView = {
        let rightView = UIView()
        self.addSubview(rightView)
        rightView.backgroundColor = UIColor.RGB(with: 229, green: 229, blue: 229)
        return rightView
    }()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        leftView.snp.makeConstraints { (make) in
            make.centerY.equalTo(label)
            make.right.equalTo(label.snp.left).offset(-10)
            make.left.equalTo(32)
            make.height.equalTo(1)
        }
        rightView.snp.makeConstraints { (make) in
            make.centerY.equalTo(label)
            make.left.equalTo(label.snp.right).offset(10)
            make.right.equalTo(-32)
            make.height.equalTo(1)
        }
        
    }
    
}
