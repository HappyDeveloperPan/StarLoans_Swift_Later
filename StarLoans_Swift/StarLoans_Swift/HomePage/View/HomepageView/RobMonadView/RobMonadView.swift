//
//  RobMonadView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/17.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class RobMonadView: UIView {

    // MARK: - 可操作数据
    var cellDataArr: [ClientInfoModel] = [ClientInfoModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - 内部属性
    fileprivate let cellHeight: CGFloat = 85
    
    // MARK: - 懒加载
    lazy var topView: HomeTopView = {
        let topView = HomeTopView()
        self.addSubview(topView)
        topView.titleLb.text = "急速抢单"
        topView.topViewCallBack = { [weak self] in
            self?.moreRobMonad()
        }
        return topView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: cellHeight)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.pan_registerCell(cell: RobMonadViewCollectionViewCell.self)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - 生命周期
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        topView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

}

// MARK: - 逻辑处理
extension RobMonadView {
    
    /// 跳转到支付页面
    ///
    /// - Parameter clientInfoModel: 数据model
    func robMonadBtnClick(_ clientInfoModel: ClientInfoModel) {
        let vc = PayViewController.loadStoryboard()
        vc.price = Float(clientInfoModel.client_price)
        vc.goodsId = clientInfoModel.client_id
        Utils.controlJump(vc, isNav: true, jumpType: .ControlJumpTypePush)
    }
    
    /// 更多抢单
    func moreRobMonad() {
        //如果用户没有登录就跳转到登录界面
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        let vc = QuickRobbingViewController()
        Utils.controlJump(vc, isNav: true, jumpType: .ControlJumpTypePush)
    }
}

extension RobMonadView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as RobMonadViewCollectionViewCell
        cell.setRobMonadViewCollectionViewCellData(with: cellDataArr[indexPath.row])
        cell.robMonadBtnCallBack = { [weak self] in
            self?.robMonadBtnClick((self?.cellDataArr[indexPath.row])!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuickBillDetailViewController.loadStoryboard()
        vc.clientModel = cellDataArr[indexPath.row]
        Utils.controlJump(vc, isNav: true, jumpType: .ControlJumpTypePush)
    }
}
