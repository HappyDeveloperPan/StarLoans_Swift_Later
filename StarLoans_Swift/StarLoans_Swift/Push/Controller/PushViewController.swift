//
//  PushViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellID = "SegmentCollectionViewCell"

class PushViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var titleBtn: UIButton = { [unowned self] in
        let titleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 30))
        titleBtn.setTitle("推单", for: .normal)
        titleBtn.setTitleColor(kTitleColor, for: .normal)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return titleBtn
    }()
    
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

        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 1.0, segmentAppearance: appearance)
        self.view.addSubview(segmentView)
        segmentView.backgroundColor = UIColor.white
        segmentView.addSegmentWithTitle("客户资源", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("金融产品", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentView
    }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 48)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.register(UINib(nibName: cellID2, bundle: nil), forCellWithReuseIdentifier: cellID2)
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
        title = ""
        view.backgroundColor = kHomeBackColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(callback))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        segmentView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom).offset(8)
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 48))
        }
        collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func callback() {
//        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.dismiss(animated: true, completion: {
        })
    }
    
    
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

//MARK: - UICollectionView代理
extension PushViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SegmentCollectionViewCell
        cell.pushType = PushType(rawValue: indexPath.row)!
        cell.setCellData(with: indexPath.row)
        return cell
    }
}

//MARK: - UIScrollView代理
extension PushViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

