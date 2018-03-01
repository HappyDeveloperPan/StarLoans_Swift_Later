//
//  InformationViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

private let cellID = "InfoSegmentCell"

class InformationViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var titleBtn: UIButton = { [unowned self] in
        let titleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 30))
        titleBtn.setTitle("消息", for: .normal)
        titleBtn.setTitleColor(kTitleColor, for: .normal)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return titleBtn
        }()
    
    lazy var settingBtn: UIButton = { [unowned self] in
        let settingBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        settingBtn.setImage(#imageLiteral(resourceName: "ICON-xiaoxishezh"), for: .normal)
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
        
        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 1.0, segmentAppearance: appearance)
        self.view.addSubview(segmentView)
        segmentView.backgroundColor = UIColor.white
        segmentView.addSegmentWithTitle("系统消息", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("交易消息", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentView
        }()
    
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 48)
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
        collectionView.register(InfoSegmentCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
        }()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        segmentView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        collectionView.layoutIfNeeded()
        layout.itemSize = CGSize(width: collectionView.width, height: collectionView.height)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    @objc func settingBtnClick(_ sender: UIButton) {
        let vc = InfoSettingViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - 数据处理部分
extension InformationViewController {
    ///获取消息列表数据
    func getInformationData(with type: InformationType ,cell: InfoSegmentCell) {
        
        var parameters = [String: Any]()
        parameters["message_type"] = type.rawValue + 1
        parameters["page"] = 1
        parameters["token"] = UserManager.shareManager.userModel.token
        
        NetWorksManager.requst(with: kUrl_InfoList, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var cellDataArr = [InfoModel]()
                    for dict in data {
                        cellDataArr.append(InfoModel(with: dict))
                    }
                    cell.cellDataArr = cellDataArr
                    cell.tableView.reloadData()
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
            cell.tableView.endHeaderRefresh()
        }
    }
    
    ///删除某一条消息
    func removeInformationData(at index: Int) {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["message_id"] = index
        
        NetWorksManager.requst(with: kUrl_removeInfo, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                print("删除成功")
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
}

//MARK: - UICollectionView代理
extension InformationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! InfoSegmentCell
        cell.delegate = self
        cell.infoType = InformationType(rawValue: indexPath.row)!
        return cell
    }
}


//MARK: - UIScrollView代理
extension InformationViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

//MARK: - InfoSegmentCell代理
extension InformationViewController: InfoSegmentCellDelegate {
    func removeCell(at index: Int) {
        removeInformationData(at: index)
    }
    
    func reloadCellData(with cell: InfoSegmentCell) {
        getInformationData(with: cell.infoType, cell: cell)
    }
}
