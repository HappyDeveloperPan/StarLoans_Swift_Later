//
//  BusinessResourceViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/11.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let teachCellID = "TeachCollectionViewCell"
fileprivate let clientListCellId = "ClientListCollectionViewCell"
fileprivate let productCellID = "ProductCollectionViewCell"

//MARK: - 界面部分
class BusinessResourceViewController: BaseViewController {

    //MARK: - 可操作数据
    ///广告栏数据
    var adverList: Array<String> = ["banner-hangyeziyuan", "banner-hangyeziyuan", "banner-hangyeziyuan"]
    
    //MARK: - 懒加载
    ///顶部广告栏
    lazy var topAdBannerView: TopAdverView = { [unowned self] in
        let topAdBannerView = TopAdverView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 235))
        self.view.addSubview(topAdBannerView)
        topAdBannerView.adverDelegate = self
        return topAdBannerView
        }()
    
    ///分段控制器
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
        
        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 0, segmentAppearance: appearance)
        self.view.addSubview(segmentView)
        segmentView.backgroundColor = UIColor.white
        segmentView.addSegmentWithTitle("进件教程", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("热门资源", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("爆款产品", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentView
        }()
    
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 200 - 45)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(TeachCollectionViewCell.self, forCellWithReuseIdentifier: teachCellID)
        collectionView.register(ClientListCollectionViewCell.self, forCellWithReuseIdentifier: clientListCellId)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: productCellID)
//        collectionView.register(UINib(nibName: cellID2, bundle: nil), forCellWithReuseIdentifier: cellID2)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "行业资源"
        view.backgroundColor = UIColor.white
        topAdBannerView.localImgArray = adverList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        ///广告栏
        topAdBannerView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(200)
        }
        topAdBannerView.layoutIfNeeded()
        
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(topAdBannerView.snp.bottom)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 45))
        }
        segmentView.layoutIfNeeded()
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 200 - 45))
        }
        collectionView.layoutIfNeeded()
    }
    
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }

}

//MARK: - 数据处理
extension BusinessResourceViewController {
    ///获取进件教程数据
    func getCourseData(with cell: TeachCollectionViewCell) {
        
        let parameters = ["type": 1,
                          "page": 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_IndustryResources, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var cellDataArr = [ResourceModel]()
                    for dict in dataArr {
                        cellDataArr.append(ResourceModel(with: dict))
                    }
                    cell.cellDataArr = cellDataArr
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
    ///获取客户资源数据
    func getClientListData(with cell: ClientListCollectionViewCell) {
        
        let parameters = ["type": 2,
                          "page": 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_IndustryResources, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var cellDataArr = [ClientInfoModel]()
                    for dict in dataArr {
                        cellDataArr.append(ClientInfoModel(with: dict))
                    }
                    cell.cellDataArr = cellDataArr
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
    ///获取爆款产品数据
    func getProductData(with cell: ProductCollectionViewCell) {
        let parameters = ["type": 3,
                          "page": 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_IndustryResources, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var cellDataArr = [ProductModel]()
                    for dict in dataArr {
                        cellDataArr.append(ProductModel(with: dict))
                    }
                    cell.cellDataArr = cellDataArr
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

//MARK: - TopAdverView代理
extension BusinessResourceViewController: TopAdverViewDelegate {
    /// 点击图片回调
    func topAdverViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
//        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动回调
    func topAdverViewDidScroll(to index: Int, cycleScrollView: WRCycleScrollView) {
//        print("滚动到了第\(index+1)个图片")
    }
}

//MARK: - UICollectionView代理
extension BusinessResourceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teachCellID, for: indexPath) as! TeachCollectionViewCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: clientListCellId, for: indexPath) as! ClientListCollectionViewCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! ProductCollectionViewCell
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - UIScrollView代理
extension BusinessResourceViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

//MARK: - TeachCollectionViewCell代理
extension BusinessResourceViewController: TeachCellDelegate {
    func reloadCellData(with cell: TeachCollectionViewCell) {
        getCourseData(with: cell)
    }
}

//MARK: - ClientListCollectionViewCell代理
extension BusinessResourceViewController: ClientListCellDelegate {
    func reloadCellData(with cell: ClientListCollectionViewCell) {
        getClientListData(with: cell)
    }
}

//MARK: - ProductCollectionViewCell代理
extension BusinessResourceViewController: ProductCellDelegate {
    func reloadCellData(with cell: ProductCollectionViewCell) {
        getProductData(with: cell)
    }
}


