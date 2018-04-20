//
//  VideoCenterCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/14.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellID = "VideoCenterDetailCollectionViewCell"

protocol VideoCenterCellDelegate: class {
    func reloadCellData(with cell: VideoCenterCollectionViewCell)
}

class VideoCenterCollectionViewCell: UICollectionViewCell {
    // MARK: - 内部属性
    fileprivate let cellWidth = 164
    fileprivate let cellHeight = 150
    // MARK: - 可操作数据
    weak var delegate: VideoCenterCellDelegate?
    var type: VideoType = .hotVideo
    var cellDataArr: [VideoModel] = [VideoModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    // MARK: - 懒加载
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.pan_registerCell(cell: VideoCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    //MARK: - 生命周期
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
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

extension VideoCenterCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as VideoCollectionViewCell
        cell.setVideoCollectionViewCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VideoDetailViewController.loadStoryboard()
        vc.videoID = cellDataArr[indexPath.row].video_id
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
