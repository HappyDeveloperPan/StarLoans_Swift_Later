//
//  QuickRobbingViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

private let cellID = "QuickRobbingSegmentCell"

class QuickRobbingViewController: BaseViewController {
    
    //MARK: - 懒加载
    lazy var settingBtn: UIButton = { [unowned self] in
        let settingBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        settingBtn.setTitle("推送设置", for: .normal)
        settingBtn.setTitleColor(UIColor.RGB(with: 51, green: 51, blue: 51), for: .normal)
        settingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        settingBtn.addTarget(self, action: #selector(settingBtnClick(_:)), for: .touchUpInside)
        return settingBtn
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
        
        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 0.0, segmentAppearance: appearance)
        self.view.addSubview(segmentView)
        segmentView.backgroundColor = UIColor.white
        segmentView.addSegmentWithTitle("精准客户", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("优质客户", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("推送订单", onSelectionImage: nil, offSelectionImage: nil)
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
        collectionView.backgroundColor = kHomeBackColor
        collectionView.register(QuickRobbingSegmentCell.self, forCellWithReuseIdentifier: cellID)
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
        title = "急速抢单"
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func settingBtnClick(_ sender: UIButton) {
        let vc = QBSettingViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }

}

//MARK: - 数据处理部分
extension QuickRobbingViewController {
    ///热门急速抢单
    func getQuickBillListData(with type: QuickRobbingType ,cell: QuickRobbingSegmentCell) {
        
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["client_type"] = type.rawValue + 1
        parameters["page"] = 1
        
        NetWorksManager.requst(with: kUrl_QuickBillList, type: .post, parameters: parameters) {(jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var cellArr = [ClientInfoModel]()
                    for dict in data {
                        cellArr.append(ClientInfoModel(with: dict))
                    }
                    cell.cellDataArr = cellArr
                    cell.collectionView.reloadData()
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
            cell.collectionView.endHeaderRefresh()
        }
    }
}

//MARK: - UICollectionView代理
extension QuickRobbingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! QuickRobbingSegmentCell
        cell.delegate = self
        cell.quickRobbingType = QuickRobbingType(rawValue: indexPath.row)!
        return cell
    }
}

//MARK: - QuickRobbingSegmentCell代理
extension QuickRobbingViewController: QuickRobbingSegmentCellDelegate {
    func reloadCellData(with cell: QuickRobbingSegmentCell) {
        getQuickBillListData(with: cell.quickRobbingType, cell: cell)
    }
}

//MARK: - UIScrollView代理
extension QuickRobbingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}
