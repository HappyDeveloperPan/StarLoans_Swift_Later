//
//  SearchView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/8.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    lazy var leftImg: UIImageView = { [unowned self] in
        let leftImg = UIImageView()
        addSubview(leftImg)
        leftImg.image = #imageLiteral(resourceName: "ICON-Search")
        return leftImg
    }()
    
    lazy var textField: UITextField = { [unowned self] in
        let textField = UITextField()
        addSubview(textField)
        textField.placeholder = "经纪人 视频 资讯"
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = UITextAutocorrectionType.no  
//        textField.spellCheckingType = UITextSpellCheckingType.no
        return textField
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
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(10)
            make.top.bottom.right.equalToSuperview()
        }
    }
    
}
