//
//  PushBillView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/9.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let leftSpace: CGFloat = 16
fileprivate let quickBillArr: [String] = ["最高可达2.5%的返佣比例",
                                          "具有行业核心竞争力的独家代理产品",
                                          "放款额度最高可达3000万，最快三天放款",
                                          "线上操作便捷高效，省时省力"]
fileprivate let publishArr: [String] = ["让闲置客户资源和产品资源发挥最大价值",
                                        "给自己的产品更多展示机会",
                                        "让发布的产品收到更多的交单"]

class PushBillView: UIVisualEffectView{
    //MARK: - 懒加载
    ///标题
    lazy var titleLB: UILabel = { [unowned self] in
        let titleLB = UILabel()
        self.contentView.addSubview(titleLB)
        titleLB.text = "推单"
        titleLB.textColor = kTitleColor
        titleLB.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return titleLB
    }()
    
    ///急速推单
    lazy var quickBillLB: UILabel = { [unowned self] in
        let quickBillLB = UILabel()
        self.contentView.addSubview(quickBillLB)
        quickBillLB.text = "急速推单"
        quickBillLB.textColor = kTitleColor
        quickBillLB.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return quickBillLB
    }()
    
    lazy var quickStrok: UIStackView = { [unowned self] in
        let quickStrok = UIStackView()
        self.contentView.addSubview(quickStrok)
        quickStrok.distribution = .fillEqually
        quickStrok.axis = .vertical
        for i in 0...quickBillArr.count-1 {
            let pushContentView = PushContentView()
            pushContentView.contentLB.text = quickBillArr[i]
            quickStrok.addArrangedSubview(pushContentView)
        }
        return quickStrok
    }()
    
    ///发布资源
    lazy var publishResourceLB: UILabel = { [unowned self] in
        let publishResourceLB = UILabel()
        self.contentView.addSubview(publishResourceLB)
        publishResourceLB.text = "发布资源"
        publishResourceLB.textColor = kTitleColor
        publishResourceLB.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return publishResourceLB
    }()
    
    lazy var publishStrok: UIStackView = { [unowned self] in
        let publishStrok = UIStackView()
        self.contentView.addSubview(publishStrok)
        publishStrok.distribution = .fillEqually
        publishStrok.axis = .vertical
        for i in 0...publishArr.count-1 {
            let pushContentView = PushContentView()
            pushContentView.contentLB.text = publishArr[i]
            publishStrok.addArrangedSubview(pushContentView)
        }
        return publishStrok
        }()
    
    ///急速推单按钮部分
    lazy var quickBillBtn: UIButton = { [unowned self] in
        let quickBillBtn = UIButton()
        self.contentView.addSubview(quickBillBtn)
        quickBillBtn.setImage(#imageLiteral(resourceName: "ICON-jisutuidan"), for: .normal)
        quickBillBtn.addTarget(self, action: #selector(quickBillBtnClick(_sender:)), for: .touchUpInside)
        return quickBillBtn
    }()
    
    lazy var quickBillBtnLB: UILabel = { [unowned self] in
        let quickBillBtnLB = UILabel()
        self.contentView.addSubview(quickBillBtnLB)
        quickBillBtnLB.text = "急速推单"
        quickBillBtnLB.textColor = kTitleColor
        quickBillBtnLB.textAlignment = .center
        quickBillBtnLB.font = UIFont.systemFont(ofSize: 17)
        return quickBillBtnLB
    }()
    ///发布资源按钮部分
    lazy var publishResourceBtn: UIButton = { [unowned self] in
        let publishResourceBtn = UIButton()
        self.contentView.addSubview(publishResourceBtn)
        publishResourceBtn.setImage(#imageLiteral(resourceName: "ICON-fabuziyuan"), for: .normal)
        publishResourceBtn.addTarget(self, action: #selector(publishResourceBtnClick(_sender:)), for: .touchUpInside)
        return publishResourceBtn
        }()
    
    lazy var publishResourceBtnLB: UILabel = { [unowned self] in
        let publishResourceBtnLB = UILabel()
        self.contentView.addSubview(publishResourceBtnLB)
        publishResourceBtnLB.text = "发布资源"
        publishResourceBtnLB.textColor = kTitleColor
        publishResourceBtnLB.textAlignment = .center
        publishResourceBtnLB.font = UIFont.systemFont(ofSize: 17)
        return publishResourceBtnLB
        }()
    ///关闭按钮
    lazy var closeBtn: UIButton = { [unowned self] in
        let closeBtn = UIButton(type: .custom)
        self.contentView.addSubview(closeBtn)
        closeBtn.setImage(#imageLiteral(resourceName: "ICON-close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeView(_sender:)), for: .touchUpInside)
        return closeBtn
        }()
    
    //MARK: - 可操作数据
    var transView:TranslucenceView?
    
    //MARK: - 生命周期
    override init(effect: UIVisualEffect?) {
        super .init(effect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super .layoutSubviews()
        titleLB.snp.makeConstraints { (make) in
            make.left.equalTo(leftSpace)
            make.top.equalTo(kStatusHeight+8)
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-kStatusHeight + 10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        quickBillLB.snp.makeConstraints { (make) in
            make.left.equalTo(leftSpace)
            make.top.equalTo(titleLB.snp.bottom).offset(45)
            make.size.equalTo(CGSize(width: 120, height: 15))
        }
        
        quickStrok.snp.makeConstraints { (make) in
            make.left.equalTo(leftSpace)
            make.top.equalTo(quickBillLB.snp.bottom).offset(10)
            make.right.equalTo(-leftSpace)
            make.height.equalTo(100)
        }
        
        publishResourceLB.snp.makeConstraints { (make) in
            make.top.equalTo(quickStrok.snp.bottom).offset(25)
            make.left.equalTo(leftSpace)
            make.size.equalTo(CGSize(width: 120, height: 15))
        }
        
        publishStrok.snp.makeConstraints { (make) in
            make.left.equalTo(leftSpace)
            make.top.equalTo(publishResourceLB.snp.bottom).offset(10)
            make.right.equalTo(-leftSpace)
            make.height.equalTo(75)
        }
        
        quickBillBtn.snp.makeConstraints { (make) in
            make.left.equalTo(72)
            make.bottom.equalTo(-kStatusHeight - 95)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        quickBillBtnLB.snp.makeConstraints { (make) in
            make.centerX.equalTo(quickBillBtn)
            make.top.equalTo(quickBillBtn.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        publishResourceBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-72)
            make.bottom.equalTo(-kStatusHeight - 95)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        publishResourceBtnLB.snp.makeConstraints { (make) in
            make.centerX.equalTo(publishResourceBtn)
            make.top.equalTo(publishResourceBtn.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
    }
    
    deinit {
        print("毛玻璃效果消失了...")
    }
    
    @objc func closeView(_sender: UIButton) {
        closeView()
    }
    
    ///急速推单
    @objc func quickBillBtnClick(_sender: UIButton) {
        closeView()
        let vc = PushProductSelectViewController()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    ///发布资源
    @objc func publishResourceBtnClick(_sender: UIButton) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            closeView()
            return
        }
        let pushView = PushResourceView()
        pushView.delegate = self
        transView = TranslucenceView(with: pushView, size: CGSize(width: 325, height: 280))
        transView?.show()
    }
    
    func closeView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
        
    }
}

//MARK: - PushResourceView代理
extension PushBillView: PushResourceViewDelegate {
    ///关闭视图
    func closePushView() {
        transView?.dismiss()
    }
    
    ///发布客户资源
    func pushcClientResource() {
        transView?.dismiss()
        closeView()
        let vc = PushClientResourceViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    ///发布贷款产品
    func pushLoansResource() {
        transView?.dismiss()
        closeView()
        let vc = PushProductResourceViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    
}

//MARK: - 中间文字部分视图
class PushContentView: UIView {
    lazy var imageView: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "ICON-xingxing")
        return imageView
    }()
    
    lazy var contentLB: UILabel = { [unowned self] in
        let contentLB = UILabel()
        self.addSubview(contentLB)
        contentLB.textColor = kTitleColor
        contentLB.font = UIFont.systemFont(ofSize: 14)
        return contentLB
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        contentLB.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(7.5)
            make.right.equalToSuperview()
            make.height.equalTo(16)
        }
    }
}
