//
//  QuickRobbingSegmentCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

enum QuickRobbingType: Int {
    case preciseClient = 0  //精准客户
    case qualityClient = 1  //优质客户
    case pushIndent = 2     //推送订单
}

protocol QuickRobbingSegmentCellDelegate: class {
    func reloadCellData(with cell: QuickRobbingSegmentCell)
}

class QuickRobbingSegmentCell: UICollectionViewCell {
    //MARK: - 可操作数据
    weak var delegate: QuickRobbingSegmentCellDelegate?
    var quickRobbingType: QuickRobbingType = .preciseClient
    var cellDataArr: [ClientInfoModel] = [ClientInfoModel]()
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

extension QuickRobbingSegmentCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as HotResourceCell
        cell.setHotResourceCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuickBillDetailViewController.loadStoryboard()
        vc.clientModel = cellDataArr[indexPath.row]
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
