//
//  ApproveSelectFooterView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ApproveSelectFooterView: UICollectionReusableView {
    
    lazy var contentLB: UILabel = { [unowned self] in
        let contentLB = UILabel()
        self.addSubview(contentLB)
        contentLB.font = UIFont.systemFont(ofSize: 12)
        contentLB.textColor = UIColor.RGB(with: 102, green: 102, blue: 102)
        contentLB.sizeToFit()
        contentLB.numberOfLines = 0
        return contentLB
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentLB.text = "提示：为提供个性化的服务，认证前您需要选择身份后才能进行认证。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        contentLB.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.equalTo(20)
            make.right.equalTo(-16)
        }
    }
}
