//
//  ClientListCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/11.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellID = "ClientListDetailCollectionViewCell"
fileprivate let footerViewID = "ClientListFooterView"
fileprivate let cellSpace = (kScreenWidth - 100 * 3) / 4

protocol ClientListCellDelegate: class {
    func reloadCellData(with cell: ClientListCollectionViewCell)
}

class ClientListCollectionViewCell: UICollectionViewCell {
    //MARK: - 可操作数据
    weak var delegate: ClientListCellDelegate?
    var cellDataArr: [ClientInfoModel] = [ClientInfoModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: - 懒加载
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth - 32, height: 160)
        layout.minimumInteritemSpacing = cellSpace
        layout.sectionInset = UIEdgeInsets(top: cellSpace, left: cellSpace, bottom: cellSpace, right: cellSpace)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = kHomeBackColor
        collectionView.pan_registerCell(cell: HotResourceCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = kHomeBackColor
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
        collectionView.layoutIfNeeded()
    }
}

extension ClientListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as HotResourceCell
        cell.setHotResourceCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ClientListDetailCollectionViewCell
//        cell.backgroundColor = UIColor.red
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.red.cgColor
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ClientListDetailCollectionViewCell
//        cell.layer.borderWidth = 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        var footerView:UICollectionReusableView?
//        if kind == UICollectionElementKindSectionFooter {
//            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewID, for: indexPath) as! ClientListFooterView
//        }
//        return footerView!
//    }
}
