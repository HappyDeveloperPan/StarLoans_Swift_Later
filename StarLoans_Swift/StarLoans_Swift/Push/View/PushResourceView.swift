//
//  PushResourceView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/10.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

protocol PushResourceViewDelegate: class {
    func pushcClientResource()
    func pushLoansResource()
    func closePushView()
}

class PushResourceView: UIView {
    @IBOutlet var content: UIView!
    
    weak var delegate: PushResourceViewDelegate?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initFromXIB()
        content.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super .init(coder: aDecoder)
        initFromXIB()
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "PushResourceView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = bounds
        self.addSubview(content)
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    @IBAction func clientBtnClick(_ sender: AnimatableButton) {
        delegate?.pushcClientResource()
    }
    @IBAction func loansBtnClick(_ sender: AnimatableButton) {
        delegate?.pushLoansResource()
    }
    @IBAction func closeBtnClick(_ sender: AnimatableButton) {
        delegate?.closePushView()
    }
    
}
