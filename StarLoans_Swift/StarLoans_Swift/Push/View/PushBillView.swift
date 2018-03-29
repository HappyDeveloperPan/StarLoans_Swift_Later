//
//  PushBillView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/9.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PushBillView: UIVisualEffectView{
    //MARK: - 内部属性
    fileprivate let leftSpace: CGFloat = 16
    fileprivate let quickBillArr: [String] = ["最高可达2.5%的返佣比例",
                                              "具有行业核心竞争力的独家代理产品",
                                              "放款额度最高可达3000万，最快三天放款",
                                              "线上操作便捷高效，省时省力"]
    fileprivate let publishArr: [String] = ["让闲置客户资源和产品资源发挥最大价值",
                                            "给自己的产品更多展示机会",
                                            "让发布的产品收到更多的交单"]
    fileprivate let buttonImg: [UIImage] = [#imageLiteral(resourceName: "ICON-jisutuidan"), #imageLiteral(resourceName: "ICON-fabuziyuan")]
    fileprivate let buttonText: [String] = ["发布抢单", "发布资源"]
    //MARK: - 内部属性
    fileprivate var buttonArr = [UIButton]()
    fileprivate var timer: Timer?
    fileprivate var buttonIndex: Int = 0
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
//    lazy var quickBillBtn: UIButton = { [unowned self] in
//        let quickBillBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
//        self.contentView.addSubview(quickBillBtn)
//        quickBillBtn.transform = CGAffineTransform(translationX: 0, y: self.bounds.size.height)
//        quickBillBtn.setTitleColor(kTitleColor, for: .normal)
//        quickBillBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        quickBillBtn.set(image: #imageLiteral(resourceName: "ICON-jisutuidan"), title: "急速推单", titlePosition: .bottom, additionalSpacing: 20, state: .normal)
//        quickBillBtn.addTarget(self, action: #selector(quickBillBtnClick(_sender:)), for: .touchUpInside)
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            quickBillBtn.transform = CGAffineTransform.identity
//        }, completion: nil)
//        return quickBillBtn
//    }()
    
//    lazy var quickBillBtnLB: UILabel = { [unowned self] in
//        let quickBillBtnLB = UILabel()
//        self.contentView.addSubview(quickBillBtnLB)
//        quickBillBtnLB.text = "急速推单"
//        quickBillBtnLB.textColor = kTitleColor
//        quickBillBtnLB.textAlignment = .center
//        quickBillBtnLB.font = UIFont.systemFont(ofSize: 17)
//        return quickBillBtnLB
//    }()
    
    ///发布资源按钮部分
//    lazy var publishResourceBtn: UIButton = { [unowned self] in
//        let publishResourceBtn = UIButton()
//        self.contentView.addSubview(publishResourceBtn)
//        publishResourceBtn.setImage(#imageLiteral(resourceName: "ICON-fabuziyuan"), for: .normal)
//        publishResourceBtn.addTarget(self, action: #selector(publishResourceBtnClick(_sender:)), for: .touchUpInside)
//        return publishResourceBtn
//        }()
//
//    lazy var publishResourceBtnLB: UILabel = { [unowned self] in
//        let publishResourceBtnLB = UILabel()
//        self.contentView.addSubview(publishResourceBtnLB)
//        publishResourceBtnLB.text = "发布资源"
//        publishResourceBtnLB.textColor = kTitleColor
//        publishResourceBtnLB.textAlignment = .center
//        publishResourceBtnLB.font = UIFont.systemFont(ofSize: 17)
//        return publishResourceBtnLB
//        }()
    
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
        setButton()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(popupBtn), userInfo: nil, repeats: true)
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
        
//        quickBillBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(72)
//            make.bottom.equalTo(-kStatusHeight - 95)
//            make.size.equalTo(CGSize(width: 160, height: 160))
//        }
//        quickBillBtnLB.snp.makeConstraints { (make) in
//            make.centerX.equalTo(quickBillBtn)
//            make.top.equalTo(quickBillBtn.snp.bottom).offset(20)
//            make.height.equalTo(20)
//        }
//        publishResourceBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(-72)
//            make.bottom.equalTo(-kStatusHeight - 95)
//            make.size.equalTo(CGSize(width: 60, height: 60))
//        }
//        publishResourceBtnLB.snp.makeConstraints { (make) in
//            make.centerX.equalTo(publishResourceBtn)
//            make.top.equalTo(publishResourceBtn.snp.bottom).offset(20)
//            make.height.equalTo(20)
//        }
        
        for i in 0..<buttonArr.count {
            let btn: UIButton = buttonArr[i]
            let btnW: CGFloat = bounds.width/2
            let btnH: CGFloat = 90
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(CGFloat(i)*btnW)
                make.bottom.equalTo(-kStatusHeight-60)
                make.size.equalTo(CGSize(width: btnW, height: btnH))
            })
        }
    }
    
    deinit {
        print("毛玻璃效果消失了...")
    }
    
    /// 创建动画按钮
    func setButton() {
        for i in 0..<buttonText.count {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            self.contentView.addSubview(btn)
            btn.transform = CGAffineTransform(translationX: 0, y: kScreenHeight)
            btn.setTitleColor(kTitleColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            btn.set(image: buttonImg[i], title: buttonText[i], titlePosition: .bottom, additionalSpacing: 20, state: .normal)
            btn.tag = i + 1
            buttonArr.append(btn)
            btn.addTarget(self, action: #selector(animaBtnClick(_:)), for: .touchUpInside)
        }
    }
    
    /// 关闭视图
    ///
    /// - Parameter _sender: 关闭按钮
    @objc func closeView(_sender: UIButton) {
        closeView()
    }
    
    /// 关闭当前毛玻璃视图
    func closeView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    /// 给每个按钮按钮事件顺序加载动画
    @objc func popupBtn() {
        if buttonIndex == buttonArr.count {
            timer?.invalidate()
            timer = nil
        }else {
            let btn = buttonArr[buttonIndex]
            setUpOneBtnAnima(button: btn)
            buttonIndex += 1
        }
    }
    
    /// 设置按钮从第一个开始向上滑动
    ///
    /// - Parameter button: 传入需要动画的button
    func setUpOneBtnAnima(button: UIButton) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            button.transform = CGAffineTransform.identity
        }) { (finished) in
            
        }
    }
    
    /// 动画按钮点击事件
    ///
    /// - Parameter _sender: 被点击的动画按钮
    @objc func animaBtnClick(_ sender: UIButton) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            closeView()
            return
        }
        switch sender.tag {
        case 1:
            pushcClientResource()
        case 2:
            pushLoansProduct()
        default:
            break
        }
    }
    
    ///发布客户资源
    func pushcClientResource() {
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
    func pushLoansProduct() {
        closeView()
        let vc = PushProductResourceViewController.loadStoryboard()
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    ///急速推单
//    @objc func quickBillBtnClick(_ sender: UIButton) {
//        closeView()
//        let vc = PushProductSelectViewController()
//        let topViewController = Utils.currentTopViewController()
//        if topViewController?.navigationController != nil{
//            topViewController?.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            topViewController?.present(vc, animated: true , completion: nil)
//        }
//    }
    
    ///发布资源
//    @objc func publishResourceBtnClick(_ sender: UIButton) {
//        guard UserManager.shareManager.isLogin else {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
//            closeView()
//            return
//        }
//        let pushView = PushResourceView()
//        pushView.delegate = self
//        transView = TranslucenceView(with: pushView, size: CGSize(width: 325, height: 280))
//        transView?.show()
//    }
}

//MARK: - PushResourceView代理
//extension PushBillView: PushResourceViewDelegate {
//    ///关闭视图
//    func closePushView() {
//        transView?.dismiss()
//    }
//
//    ///发布客户资源
//    func pushcClientResource() {
//        transView?.dismiss()
//        closeView()
//        let vc = PushClientResourceViewController.loadStoryboard()
//        let topViewController = Utils.currentTopViewController()
//        if topViewController?.navigationController != nil{
//            topViewController?.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            topViewController?.present(vc, animated: true , completion: nil)
//        }
//    }
//
//    ///发布贷款产品
//    func pushLoansResource() {
//        transView?.dismiss()
//        closeView()
//        let vc = PushProductResourceViewController.loadStoryboard()
//        let topViewController = Utils.currentTopViewController()
//        if topViewController?.navigationController != nil{
//            topViewController?.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            topViewController?.present(vc, animated: true , completion: nil)
//        }
//    }
//
//
//}

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
