//
//  LoansProductView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

@IBDesignable
class LoansProductView: UIView {
    
    @IBOutlet var content: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var rtTitle1: UILabel!
    @IBOutlet weak var rtTitle2: UILabel!
    @IBOutlet weak var loansNum: UILabel!
    //MARK: - 懒加载
    //MARK: - 底部控件
    //返佣
    lazy var lbTitileLb: UILabel = { [unowned self] in
        let lbTitileLb = UILabel()
        self.addSubview(lbTitileLb)
        lbTitileLb.text = "返佣"
        lbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        lbTitileLb.textAlignment = .center
        lbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return lbTitileLb
        }()
    lazy var lbContentLb: UILabel = { [unowned self] in
        let lbContentLb = UILabel()
        self.addSubview(lbContentLb)
        lbContentLb.text = "2%"
        lbContentLb.textColor = kMainColor
        lbContentLb.textAlignment = .center
        lbContentLb.font = UIFont.systemFont(ofSize: 14)
        return lbContentLb
        }()
    
    //领取金额
    lazy var cbTitileLb: UILabel = { [unowned self] in
        let cbTitileLb = UILabel()
        self.addSubview(cbTitileLb)
        cbTitileLb.text = "领取金额"
        cbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        cbTitileLb.textAlignment = .center
        cbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return cbTitileLb
        }()
    lazy var cbContentLb: UILabel = { [unowned self] in
        let cbContentLb = UILabel()
        self.addSubview(cbContentLb)
        cbContentLb.text = "200万"
        cbContentLb.textColor = kMainColor
        cbContentLb.textAlignment = .center
        cbContentLb.font = UIFont.systemFont(ofSize: 14)
        return cbContentLb
        }()
    
    //已领人数
    lazy var rbTitileLb: UILabel = { [unowned self] in
        let rbTitileLb = UILabel()
        self.addSubview(rbTitileLb)
        rbTitileLb.text = "已领人数"
        rbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        rbTitileLb.textAlignment = .center
        rbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return rbTitileLb
        }()
    lazy var rbContentLb: UILabel = { [unowned self] in
        let rbContentLb = UILabel()
        self.addSubview(rbContentLb)
        rbContentLb.text = "102"
        rbContentLb.textColor = kMainColor
        rbContentLb.textAlignment = .center
        rbContentLb.font = UIFont.systemFont(ofSize: 14)
        return rbContentLb
        }()
    //竖线
    lazy var leftVerticalLine: UIView = { [unowned self] in
        let leftVerticalLine = UIView()
        self.addSubview(leftVerticalLine)
        leftVerticalLine.backgroundColor = UIColor.RGB(with: 217, green: 217, blue: 217)
        return leftVerticalLine
        }()
    lazy var rightVerticalLine: UIView = { [unowned self] in
        let rightVerticalLine = UIView()
        self.addSubview(rightVerticalLine)
        rightVerticalLine.backgroundColor = UIColor.RGB(with: 217, green: 217, blue: 217)
        return rightVerticalLine
        }()
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        initFromXIB()
    }
    
    func setupBasic() {
        rtTitle1.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        rtTitle1.layer.cornerRadius = rtTitle1.height/2
        rtTitle2.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        rtTitle2.layer.cornerRadius = rtTitle1.height/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        initFromXIB()
    }
    
    func initFromXIB() {
        
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "LoansProductView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = bounds
        self.addSubview(content)
        
        setupBasic()
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        ///底部控件
        lbContentLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3, height: 14))
        }
        lbTitileLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(lbContentLb.snp.top).offset(-18)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3, height: 14))
        }
        
        cbContentLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3-1, height: 14))
        }
        cbTitileLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(cbContentLb.snp.top).offset(-18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3-1, height: 14))
        }
        
        rbContentLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3, height: 14))
        }
        rbTitileLb.snp.makeConstraints { (make) in
            make.bottom.equalTo(rbContentLb.snp.top).offset(-18)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: width/3, height: 14))
        }
        //线条
        leftVerticalLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.left.equalTo(width/3)
            make.size.equalTo(CGSize(width: 0.5, height: 45))
        }
        rightVerticalLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.right.equalTo(-width/3)
            make.size.equalTo(CGSize(width: 0.5, height: 45))
        }
    }
    
}
