//
//  LoansSegmentCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

enum LoansProductType: Int {
    case selfSupport = 0    //自营
    case thirdSupport = 1   //第三方
}

protocol LoansSegmentCellDelegate: class {
    func reloadCellData(with cell: LoansSegmentCell)
}

class LoansSegmentCell: UICollectionViewCell {
    //MARK: - 可操作数据
    weak var delegate: LoansSegmentCellDelegate?
    var loansProductType: LoansProductType = .selfSupport
    var cellDataArr: [ProductModel] = [ProductModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: - 懒加载
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth - 32, height: 160)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = kHomeBackColor
        collectionView.pan_registerCell(cell: ProductDetailCollectionViewCell.self)
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
//        collectionView.layoutIfNeeded()
    }
}

extension LoansSegmentCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as ProductDetailCollectionViewCell
        cell.loansProductType = loansProductType
        cell.setProductListCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LoansDetailViewController.loadStoryboard()
        vc.loansProductType = loansProductType
        vc.productModel = cellDataArr[indexPath.row]
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
