//
//  ClientListFooterView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class ClientListFooterView: UICollectionReusableView {
    
    lazy var commitBtn: UIButton = { [unowned self] in
        let commitBtn = UIButton()
        self.addSubview(commitBtn)
        commitBtn.backgroundColor = kMainColor
        commitBtn.setTitle("确认支付", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        commitBtn.layer.cornerRadius = 22.5
        return commitBtn
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        commitBtn.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 45))
        })
    }
    
}
