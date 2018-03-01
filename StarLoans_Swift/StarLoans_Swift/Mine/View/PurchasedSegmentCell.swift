//
//  PurchasedSegmentCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

enum PurchasedSegmentType: Int {
    case all = 0        //全部
    case video = 1      //视频
    case tool = 2       //推广工具
    case course = 3     //文案教程
}

protocol PurchasedSegmentCellDelegate: class {
    func reloadCellData(with cell: PurchasedSegmentCell)
}

class PurchasedSegmentCell: UICollectionViewCell {
    
    //MARK: - 可操作数据
    weak var delegate: PurchasedSegmentCellDelegate?
    var purchasedSegmentType: PurchasedSegmentType = .all
    var cellDataArr: [ProductModel] = [ProductModel]()
    //MARK: - 懒加载
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: 150)
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = kHomeBackColor
        collectionView.pan_registerCell(cell: PurchasedCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        collectionView.addHeaderRefresh { [weak self] in
            self?.delegate?.reloadCellData(with: self!)
        }
        collectionView.beginHeaderRefresh()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension PurchasedSegmentCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as PurchasedCell
//        cell.loansProductType = loansProductType
//        cell.setCellData(with: loansProductType.rawValue)
        return cell
    }
}
