//
//  TranslucenceView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/10.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class TranslucenceView: UIView {
    
    let kScrW:CGFloat = UIScreen.main.bounds.size.width
    let kScrH:CGFloat = UIScreen.main.bounds.size.height

    override init(frame: CGRect) {
        super .init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: kScrW, height: kScrH)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with customView: UIView, size: CGSize) {
        self .init()
        self.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(size)
        }
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 1
        }) { (finish) in
        }
    }
    
    public func dismiss() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (finish) in
            self?.removeFromSuperview()
        }
    }
    
}
