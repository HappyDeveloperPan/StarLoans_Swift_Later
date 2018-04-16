//
//  QSMarqueeCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class QSMarqueeCollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        label.numberOfLines = 1
        label.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(contentView.size.height)
        }
        label.layoutIfNeeded()
    }
}
