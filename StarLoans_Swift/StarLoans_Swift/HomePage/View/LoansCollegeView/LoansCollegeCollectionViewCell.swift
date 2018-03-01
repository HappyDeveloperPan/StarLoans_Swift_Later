//
//  LoansCollegeCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/13.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate let cellID = "TeachDetailCollectionViewCell"

protocol LoansCollegeCollectionViewCellDelegate: class {
    func reloadCellData(with cell: LoansCollegeCollectionViewCell)
}

class LoansCollegeCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    
    //MARK: - 可操作数据
    weak var delegate: LoansCollegeCollectionViewCellDelegate?
    var type: loansCollegeType = .newcomerGuide
    var cellArr: [ResourceModel] = [ResourceModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: - 懒加载
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth - 32, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = kHomeBackColor
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
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

extension LoansCollegeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TeachDetailCollectionViewCell
        let cellModel = cellArr[indexPath.row]
        cell.setTeachDetailCellData(with: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = LoansCollegeDetailViewController.loadStoryboard()
        let vc = InformationShowViewController.loadStoryboard()
        vc.title = "推单教学"
        vc.resourceModel = cellArr[indexPath.row]
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
