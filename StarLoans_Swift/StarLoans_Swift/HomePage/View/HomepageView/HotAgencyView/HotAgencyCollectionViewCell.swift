//
//  HotAgencyCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/5.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class HotAgencyCollectionViewCell: UICollectionViewCell {
    //MARK: - 懒加载
    //MARK: - 顶部标题
    lazy var topBackView: UIView = { [unowned self] in
        let topBackView = UIView()
        contentView.addSubview(topBackView)
//        topBackView.backgroundColor = kMainColor
        return topBackView
    }()
    
    lazy var topImgView: UIImageView = { [unowned self] in
        let topImgView = UIImageView()
        topBackView.addSubview(topImgView)
        topImgView.image = #imageLiteral(resourceName: "ICON-topRedImg")
        return topImgView
    }()
    
    lazy var topCenterLB: UILabel = { [unowned self] in
        let topCenterLB = UILabel()
        topImgView.addSubview(topCenterLB)
        topCenterLB.text = "宅e贷"
        topCenterLB.textColor = UIColor.white
        topCenterLB.textAlignment = .center
        topCenterLB.font = UIFont.systemFont(ofSize: 18)
        return topCenterLB
    }()
    
    lazy var leftTopLB: UILabel = { [unowned self] in
        let leftTopLB = UILabel()
        topBackView.addSubview(leftTopLB)
        leftTopLB.text = "抵押贷款"
        leftTopLB.textColor = UIColor.white
        leftTopLB.textAlignment = .center
        leftTopLB.font = UIFont.systemFont(ofSize: 12)
        leftTopLB.layer.cornerRadius = 10.5
        leftTopLB.layer.borderWidth = 1
        leftTopLB.layer.borderColor = UIColor.white.cgColor
        return leftTopLB
    }()
    
    //MARK: - 中间控件
    lazy var logoImg: UIImageView = { [unowned self] in
        let logoImg = UIImageView()
        contentView.addSubview(logoImg)
        logoImg.image = #imageLiteral(resourceName: "WechatIMG16")
        return logoImg
    }()
    lazy var quikAuditLB: UILabel = { [unowned self] in
        let quikAuditLB = UILabel()
        contentView.addSubview(quikAuditLB)
        quikAuditLB.text = "极速审核"
        quikAuditLB.textColor = UIColor.RGB(with: 245, green: 78, blue: 78)
        quikAuditLB.textAlignment = .center
        quikAuditLB.font = UIFont.systemFont(ofSize: 12)
        quikAuditLB.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        quikAuditLB.layer.cornerRadius = 10.5
        return quikAuditLB
    }()
    //中间价格
    lazy var centerPriceLB: UILabel = { [unowned self] in
        let centerPriceLB = UILabel()
        contentView.addSubview(centerPriceLB)
        centerPriceLB.text = "99"
        centerPriceLB.textColor = kMainColor
        centerPriceLB.textAlignment = .center
        centerPriceLB.adjustsFontSizeToFitWidth = true
        centerPriceLB.font = UIFont.systemFont(ofSize: 65)
        return centerPriceLB
    }()
    lazy var wanLB: UILabel = { [unowned self] in
        let wanLB = UILabel()
        contentView.addSubview(wanLB)
        wanLB.text = "万"
        wanLB.textColor = kTitleColor
        wanLB.textAlignment = .left
        wanLB.font = UIFont.systemFont(ofSize: 20)
        return wanLB
    }()
    lazy var zuigaoLB: UILabel = { [unowned self] in
        let zuigaoLB = UILabel()
        contentView.addSubview(zuigaoLB)
        zuigaoLB.text = "最高可贷"
        zuigaoLB.textColor = UIColor.RGB(with: 102, green: 102, blue: 102)
        zuigaoLB.textAlignment = .center
        zuigaoLB.font = UIFont.systemFont(ofSize: 14)
        return zuigaoLB
    }()
    
    //MARK: - 底部控件
    //返佣
    lazy var lbTitileLb: UILabel = { [unowned self] in
        let lbTitileLb = UILabel()
        contentView.addSubview(lbTitileLb)
        lbTitileLb.text = "返佣"
        lbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        lbTitileLb.textAlignment = .center
        lbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return lbTitileLb
    }()
    lazy var lbContentLb: UILabel = { [unowned self] in
        let lbContentLb = UILabel()
        contentView.addSubview(lbContentLb)
        lbContentLb.text = "2%"
        lbContentLb.textColor = kMainColor
        lbContentLb.textAlignment = .center
        lbContentLb.font = UIFont.systemFont(ofSize: 14)
        return lbContentLb
    }()
    
    //领取金额
    lazy var cbTitileLb: UILabel = { [unowned self] in
        let cbTitileLb = UILabel()
        contentView.addSubview(cbTitileLb)
        cbTitileLb.text = "领取金额"
        cbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        cbTitileLb.textAlignment = .center
        cbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return cbTitileLb
    }()
    lazy var cbContentLb: UILabel = { [unowned self] in
        let cbContentLb = UILabel()
        contentView.addSubview(cbContentLb)
        cbContentLb.text = "200万"
        cbContentLb.textColor = kMainColor
        cbContentLb.textAlignment = .center
        cbContentLb.font = UIFont.systemFont(ofSize: 14)
        return cbContentLb
    }()
    
    //已领人数
    lazy var rbTitileLb: UILabel = { [unowned self] in
        let rbTitileLb = UILabel()
        contentView.addSubview(rbTitileLb)
        rbTitileLb.text = "已领人数"
        rbTitileLb.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        rbTitileLb.textAlignment = .center
        rbTitileLb.font = UIFont.systemFont(ofSize: 14)
        return rbTitileLb
    }()
    lazy var rbContentLb: UILabel = { [unowned self] in
        let rbContentLb = UILabel()
        contentView.addSubview(rbContentLb)
        rbContentLb.text = "102"
        rbContentLb.textColor = kMainColor
        rbContentLb.textAlignment = .center
        rbContentLb.font = UIFont.systemFont(ofSize: 14)
        return rbContentLb
        }()
    //竖线
    lazy var leftVerticalLine: UIView = { [unowned self] in
        let leftVerticalLine = UIView()
        contentView.addSubview(leftVerticalLine)
        leftVerticalLine.backgroundColor = UIColor.RGB(with: 217, green: 217, blue: 217)
        return leftVerticalLine
    }()
    lazy var rightVerticalLine: UIView = { [unowned self] in
        let rightVerticalLine = UIView()
        contentView.addSubview(rightVerticalLine)
        rightVerticalLine.backgroundColor = UIColor.RGB(with: 217, green: 217, blue: 217)
        return rightVerticalLine
        }()
    //MARK: - 任务按钮
    lazy var taskBtn: UIButton = { [unowned self] in
        let taskBtn = UIButton()
        contentView.addSubview(taskBtn)
        taskBtn.setTitle("领取任务", for: .normal)
        taskBtn.setTitleColor(UIColor.white, for: .normal)
        taskBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        taskBtn.backgroundColor = kMainColor
        taskBtn.layer.cornerRadius = 17.5
        taskBtn.addTarget(self, action: #selector(taskBtnClick(_:)), for: .touchUpInside)
        return taskBtn
    }()
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 6
        layer.shadowColor = kLineColor.cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 0, height: 0)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5//阴影透明度，默认0
        layer.shadowRadius = 4//阴影半径，默认3
        layer.masksToBounds = false

//        contentView.layer.cornerRadius = 6
//        contentView.layer.masksToBounds = true
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = self.frame
        
//        let borderLayer = CAShapeLayer()
//        borderLayer.frame = self.frame
//        borderLayer.lineWidth = 1
//        borderLayer.strokeColor = kMainColor.cgColor
//        borderLayer.fillColor = UIColor.clear.cgColor
        
//        let bezierPath = UIBezierPath(roundedRect: self.frame, cornerRadius: 6)
//        maskLayer.path = bezierPath.cgPath
//        borderLayer.path = bezierPath.cgPath
        
//        contentView.layer.insertSublayer(borderLayer, at: 0)
//        layer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        ///顶部标题
        topBackView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        topImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        topCenterLB.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 18))
        }
        
        leftTopLB.snp.makeConstraints { (make) in
            make.left.equalTo(6.5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 21))
        }
        
        ///中间控件
        logoImg.snp.makeConstraints { (make) in
            make.left.equalTo(6.5)
            make.top.equalTo(topBackView.snp.bottom).offset(15)
        }
        quikAuditLB.snp.makeConstraints { (make) in
            make.top.equalTo(topBackView.snp.bottom).offset(15)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 56, height: 21))
        }
        centerPriceLB.snp.makeConstraints { (make) in
            make.top.equalTo(104)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        wanLB.snp.makeConstraints { (make) in
            make.top.equalTo(134)
            make.left.equalTo(centerPriceLB.snp.right)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        zuigaoLB.snp.makeConstraints { (make) in
            make.top.equalTo(centerPriceLB.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 14))
        }
        
        ///底部控件
        //金融栏
        lbTitileLb.snp.makeConstraints { (make) in
            make.top.equalTo(198)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 14))
        }
        lbContentLb.snp.makeConstraints { (make) in
            make.top.equalTo(lbTitileLb.snp.bottom).offset(19)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 14))
        }
        cbTitileLb.snp.makeConstraints { (make) in
            make.top.equalTo(198)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 14))
        }
        cbContentLb.snp.makeConstraints { (make) in
            make.top.equalTo(cbTitileLb.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 14))
        }
        rbTitileLb.snp.makeConstraints { (make) in
            make.top.equalTo(198)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 14))
        }
        rbContentLb.snp.makeConstraints { (make) in
            make.top.equalTo(rbTitileLb.snp.bottom).offset(19)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 14))
        }
        //线条
        leftVerticalLine.snp.makeConstraints { (make) in
            make.top.equalTo(198)
            make.left.equalTo(94)
            make.size.equalTo(CGSize(width: 1, height: 45))
        }
        rightVerticalLine.snp.makeConstraints { (make) in
            make.top.equalTo(198)
            make.right.equalTo(-95)
            make.size.equalTo(CGSize(width: 1, height: 45))
        }
        //任务按钮
        taskBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 175, height: 35))
        }
    }
    
    @objc func taskBtnClick(_ sender: UIButton) {
        //如果用户没有登录就跳转到登录界面
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        let vc = AuthorizationViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
}

extension HotAgencyCollectionViewCell {
    func setHotAgencyData(with cellModel: ProductModel) {
        topCenterLB.text = cellModel.product
        centerPriceLB.text = cellModel.quota
        lbContentLb.text = String(cellModel.return_commission) + "%"
        cbContentLb.text = String(cellModel.claim_amount) + "万"
        rbContentLb.text = String(cellModel.leader_number) + "人"
    }
}
