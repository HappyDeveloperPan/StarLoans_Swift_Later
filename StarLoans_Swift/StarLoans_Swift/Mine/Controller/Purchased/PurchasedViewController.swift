//
//  PurchasedViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

private let cellID = "PurchasedSegmentCell"

class PurchasedViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var segmentView: SMSegmentView = { [unowned self] in
        let appearance = SMSegmentAppearance()
        appearance.segmentOnSelectionColour = UIColor.white
        appearance.segmentOffSelectionColour = UIColor.white
        appearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 15.0)
        appearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 15.0)
        appearance.titleOnSelectionColour = kMainColor
        appearance.titleOffSelectionColour = kTitleColor
        appearance.contentVerticalMargin = 10.0
        appearance.titleGravity = .right
        
        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 0.0, segmentAppearance: appearance)
        self.view.addSubview(segmentView)
        segmentView.backgroundColor = UIColor.white
        segmentView.addSegmentWithTitle(" 全部 ", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle(" 视频 ", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("推广工具", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("文案教程", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentView
        }()
    
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 45)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.register(PurchasedSegmentCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "已购"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }

    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()

        segmentView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 45))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        collectionView.layoutIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }

}

//MARK: - 数据处理部分
extension PurchasedViewController {
    ///获取已购数据
    func getPurchasedData(with type: PurchasedSegmentType ,cell: PurchasedSegmentCell) {
        cell.collectionView.endHeaderRefresh()
    }
}

//MARK: - UICollectionView代理
extension PurchasedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PurchasedSegmentCell
        cell.delegate = self
        cell.purchasedSegmentType = PurchasedSegmentType(rawValue: indexPath.row)!
        return cell
    }
}


//MARK: - UIScrollView代理
extension PurchasedViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

extension PurchasedViewController: PurchasedSegmentCellDelegate {
    func reloadCellData(with cell: PurchasedSegmentCell) {
        getPurchasedData(with: cell.purchasedSegmentType, cell: cell)
    }
}
