//
//  HotProductView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/17.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class HotProductView: UIView {
    // MARK: - 可操作数据
    var cellDataArr: [ProductModel] = [ProductModel]() {
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
        topView.titleLb.text = "热门产品"
        topView.topViewCallBack = { [weak self] in
            self?.hotProductMore()
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
        collectionView.pan_registerCell(cell: HotProductCollectionViewCell.self)
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
    
    /// 更多热门产品
    func hotProductMore() {
        JSProgress.showInfoWithStatus(with: "敬请期待")
    }
}

// MARK: - UICollectionView代理
extension HotProductView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as HotProductCollectionViewCell
        cell.setHotProductCollectionViewCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LoansDetailViewController.loadStoryboard()
        let cellModel: ProductModel
        if cellDataArr.count == 0 {
            cellModel = ProductModel()
        }else {
            cellModel = cellDataArr[indexPath.item%cellDataArr.count]
        }
        vc.loansProductType = .selfSupport
        vc.productModel = cellModel
        vc.productModel.product_id = cellModel.id
        Utils.controlJump(vc, isNav: true, jumpType: .ControlJumpTypePush)
    }
}

/// 顶部视图
class HomeTopView: UIView {
    lazy var redView: UIView = {
        let redView = UIView()
        self.addSubview(redView)
        redView.backgroundColor = kMainColor
        return redView
    }()
    
    lazy var titleLb: UILabel = {
        let titleLb = UILabel()
        self.addSubview(titleLb)
        titleLb.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLb.textColor = UIColor.RGB(with: 51, green: 51, blue: 51)
        return titleLb
    }()
    
    lazy var arrowView: UIImageView = {
        let arrowView = UIImageView()
        self.addSubview(arrowView)
        arrowView.image = #imageLiteral(resourceName: "ICON-more")
        return arrowView
    }()
    
    var topViewCallBack: (()->()) = {}
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(topViewClick))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        redView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 5, height: 20))
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(redView.snp.right).offset(16)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
        }
    }
    
    @objc func topViewClick() {
        topViewCallBack()
    }
}
