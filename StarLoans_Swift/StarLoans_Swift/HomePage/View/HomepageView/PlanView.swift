//
//  PlanView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class PlanView: UIView {

    //MARK: - 懒加载
    lazy var topMoreBtn: UIButton = { [unowned self] in
        let topMoreBtn = UIButton()
        addSubview(topMoreBtn)
        topMoreBtn.setTitle("活动中心", for: .normal)
        topMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        topMoreBtn.setTitleColor(UIColor.RGB(with: 51, green: 51, blue: 51), for: .normal)
        topMoreBtn.setImage(#imageLiteral(resourceName: "ICON-huodong"), for: .normal)
//        topMoreBtn.addTarget(self, action: #selector(topMoreBtnClick(_:)), for: .touchUpInside)
        return topMoreBtn
        }()
    
    lazy var centerLine: UIView = { [unowned self] in
        let centerLine = UIView()
        addSubview(centerLine)
        centerLine.backgroundColor = kHomeBackColor
        return centerLine
    }()
    
    lazy var leftImage: UIImageView = { [unowned self] in
        let leftImage = UIImageView()
        addSubview(leftImage)
        leftImage.backgroundColor = kHomeBackColor
        leftImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imgClick(_:))))
        leftImage.isUserInteractionEnabled = true
        return leftImage
    }()
    
    lazy var topRightImage: UIImageView = { [unowned self] in
        let topRightImage = UIImageView()
        addSubview(topRightImage)
        topRightImage.backgroundColor = kHomeBackColor
        topRightImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightClick(_:))))
        topRightImage.isUserInteractionEnabled = true
        return topRightImage
        }()
    
    lazy var bottomRightImage: UIImageView = { [unowned self] in
        let bottomRightImage = UIImageView()
        addSubview(bottomRightImage)
        bottomRightImage.backgroundColor = kHomeBackColor
        return bottomRightImage
        }()
    //MARK: - 外部属性
//    var imgUrl: String = ""
    var dataArr = [HomePageModel]() {
        didSet {
            setPlanViewData(dataArr)
        }
    }
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
        topMoreBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        
        centerLine.snp.makeConstraints { (make) in
            make.top.equalTo(topMoreBtn.snp.bottom)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 1))
        }
        
        leftImage.snp.makeConstraints { (make) in
            make.top.equalTo(centerLine.snp.bottom).offset(7.5)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 165, height: 150))
        }
        
        topRightImage.snp.makeConstraints { (make) in
            make.top.equalTo(centerLine.snp.bottom).offset(7.5)
            make.right.equalTo(-16)
            make.size.equalTo(CGSize(width: 165, height: 150))
        }
        
//        bottomRightImage.snp.makeConstraints { (make) in
//            make.bottom.equalTo(-7.5)
//            make.right.equalTo(-16)
//            make.size.equalTo(CGSize(width: 165, height: 70))
//        }
        
    }
    
    @objc func topMoreBtnClick(_ sender: UIButton) {
        print("信用卡专区")
    }
    
    @objc func imgClick(_ sender: UIGestureRecognizer) {
        guard !dataArr[0].url.isEmpty else {
            return
        }
        let vc = ActivityCenterViewController()
        vc.url = dataArr[0].url
        vc.title = dataArr[0].title
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    @objc func topRightClick(_ sender: UIGestureRecognizer) {
        guard !dataArr[1].url.isEmpty else {
            return
        }
        let vc = ActivityCenterViewController()
        vc.url = dataArr[1].url
        vc.title = dataArr[1].title
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}

extension PlanView {
    func setPlanViewData(_ dataArr: [HomePageModel]) {
        for i in 0...dataArr.count - 1 {
            let data = dataArr[i]
            switch i {
            case 0:
                leftImage.setImage(with: data.img)
            case 1:
                topRightImage.setImage(with: data.img)
//            case 2:
//                bottomRightImage.setImage(with: data.img)
            default:break
            }
        }
    }
}
