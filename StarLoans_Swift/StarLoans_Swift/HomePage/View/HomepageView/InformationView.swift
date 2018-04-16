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
        self.addSubview(leftImg)
        leftImg.image = #imageLiteral(resourceName: "ICON-news")
        return leftImg
    }()
    
    lazy var marqueeView: QSMarqueeView = {
        let marqueeView = QSMarqueeView()
        self.addSubview(marqueeView)
        marqueeView.bgColor = UIColor.RGB(with: 247, green: 247, blue: 247)
        marqueeView.font = UIFont.systemFont(ofSize: 12)
        marqueeView.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        return marqueeView
    }()
    
    var textArr = [String]() {
        didSet {
            marqueeView.textArr = textArr
        }
    }

    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.RGB(with: 247, green: 247, blue: 247)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 15))
        }
        leftImg.layoutIfNeeded()
        
        marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(10)
            make.top.bottom.right.equalToSuperview()
        }
        marqueeView.layoutIfNeeded()
    }
}
