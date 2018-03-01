//
//  SegmentCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/9.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let dataArr:Array<Dictionary<String, Any>> = [
    ["text":"在这里您可以发布有偿的客户资源，通过编辑客户的基本资料、贷款需求等信息，提交至客户端。在通过审核后，平台会将您发布的客户资源展示在“极速抢单”的列表，供其他经纪人购买，从中您可要获得一定的收益。", "image": #imageLiteral(resourceName: "kehuziyuan"), "commitText":"立即发布"],
    ["text":"在这里可以发布您所在公司的金融产品，经平台在线审核后，可以通过平台获取更多的客户办理您的产品。", "image": #imageLiteral(resourceName: "jinrongcanpin"), "commitText":"立即推单"]]

enum PushType: Int{
    case clientResource = 0 //客户资源
    case financeProduct = 1 //金融产品
}

class SegmentCollectionViewCell: UICollectionViewCell {
    
    var pushType: PushType = .clientResource
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        self.contentView.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy var topTitleImg: UIImageView = { [unowned self] in
        let topTitleImg = UIImageView()
        self.scrollView.addSubview(topTitleImg)
        topTitleImg.image = #imageLiteral(resourceName: "ICON-jibenjieshao")
        return topTitleImg
        }()
    
    lazy var topTitleLB: UILabel = { [unowned self] in
        let topTitleLB = UILabel()
        self.scrollView.addSubview(topTitleLB)
        topTitleLB.text = "基本介绍"
        topTitleLB.textColor = kTitleColor
        topTitleLB.font = UIFont.boldSystemFont(ofSize: 15)
        return topTitleLB
    }()

    lazy var contentLB: UILabel = { [unowned self] in
        let contentLB = UILabel()
        self.scrollView.addSubview(contentLB)
        contentLB.textColor = kTitleColor
        contentLB.font = UIFont.systemFont(ofSize: 14)
        return contentLB
    }()
    
    lazy var cutLine: UIView = { [unowned self] in
        let cutLine = UIView()
        self.scrollView.addSubview(cutLine)
        cutLine.backgroundColor = kHomeBackColor
        return cutLine
    }()
    
    lazy var centerTitleLB: UILabel = { [unowned self] in
        let centerTitleLB = UILabel()
        self.scrollView.addSubview(centerTitleLB)
        centerTitleLB.text = "发布流程"
        centerTitleLB.textColor = kTitleColor
        centerTitleLB.font = UIFont.boldSystemFont(ofSize: 15)
        return centerTitleLB
    }()
    
    lazy var contentImg: UIImageView = { [unowned self] in
        let contentImg = UIImageView()
        self.scrollView.addSubview(contentImg)
        contentImg.image = #imageLiteral(resourceName: "kehuziyuan")
        return contentImg
    }()
    
    lazy var commitBtn: UIButton = { [unowned self] in
        let commitBtn = UIButton()
        self.scrollView.addSubview(commitBtn)
        commitBtn.setTitle("立即发布", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        commitBtn.layer.cornerRadius = 22.5
        commitBtn.backgroundColor = kMainColor
        commitBtn.addTarget(self, action: #selector(commitBtnClick(_:)), for: .touchUpInside)
        return commitBtn
    }()
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
//        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        topTitleImg.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 14.5, height: 14))
        }
        topTitleImg.layoutIfNeeded()
        topTitleLB.snp.makeConstraints { (make) in
            make.left.equalTo(topTitleImg.snp.right).offset(5)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 80, height: 15))
        }
        topTitleLB.layoutIfNeeded()
    
        contentLB.snp.makeConstraints { (make) in
            make.top.equalTo(topTitleLB.snp.bottom).offset(16)
            make.left.equalTo(36)
            make.width.equalTo(kScreenWidth - 36 - 20)
        }
        contentLB.numberOfLines = 0
        contentLB.sizeToFit()
        contentLB.layoutIfNeeded()
        
        cutLine.snp.makeConstraints { (make) in
            make.top.equalTo(contentLB.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth - 32, height: 1))
        }
        cutLine.layoutIfNeeded()
        
        centerTitleLB.snp.makeConstraints { (make) in
            make.left.equalTo(36)
            make.top.equalTo(cutLine.snp.bottom).offset(14)
            make.size.equalTo(CGSize(width: 80, height: 15))
        }
        centerTitleLB.layoutIfNeeded()
        
        contentImg.snp.makeConstraints { (make) in
            make.top.equalTo(centerTitleLB.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenWidth - 40)
        }
        contentImg.layoutIfNeeded()
        
        commitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentImg.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 45))
            make.bottom.equalTo(-20)
        }
        commitBtn.layoutIfNeeded()
        
        scrollView.layoutIfNeeded()
//        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight * 2)
    }
    
    @objc func commitBtnClick(_ sender: UIButton) {
        if pushType == .clientResource {
            let vc = PushClientResourceViewController.loadStoryboard()
            let topViewController = Utils.currentTopViewController()
            if topViewController?.navigationController != nil{
                topViewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                topViewController?.present(vc, animated: true , completion: nil)
            }
        }
        if pushType == .financeProduct {
            let vc = PushProductResourceViewController.loadStoryboard()
            let topViewController = Utils.currentTopViewController()
            if topViewController?.navigationController != nil{
                topViewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                topViewController?.present(vc, animated: true , completion: nil)
            }
        }
    }
    
}

extension SegmentCollectionViewCell {
    func setCellData(with index: Int) {
//        contentLB.text = "收到付款节食减肥就是垃圾类似的纠纷就是独立房姐流水了房姐历史记录经理说的熟练度废旧塑料市劳动纠纷说了积分失落的房间是独立房姐司法鉴定记录是否类似纠纷"
        contentLB.text = dataArr[index]["text"] as? String
        contentImg.image = dataArr[index]["image"] as? UIImage
        commitBtn.setTitle(dataArr[index]["commitText"] as? String, for: .normal)
    }
}
