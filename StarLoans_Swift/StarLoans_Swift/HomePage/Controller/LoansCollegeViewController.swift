//
//  LoansCollegeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let collegeCellID = "LoansCollegeCollectionViewCell"

enum loansCollegeType: Int {
    case newcomerGuide = 0
    case skilltrain = 1
    case customerstrategy = 2
}

//MARK: - 界面部分
class LoansCollegeViewController: UIViewController {
    
//    enum type: Int {
//        case newcomerGuide = 0
//        case skilltrain = 1
//        case customerstrategy = 2
//    }
    
    //MARK: - 可操作数据
    ///广告栏数据
    var adverList: Array<String> = ["banner-hangyeziyuan", "banner-hangyeziyuan", "banner-hangyeziyuan"]
    var identifierDic = [String: String]()
    //MARK: - 懒加载
    ///顶部广告栏
    lazy var topAdBannerView: TopAdverView = { [unowned self] in
        let topAdBannerView = TopAdverView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
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
        segmentView.addSegmentWithTitle("新手指引", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("技能培训", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("获客攻略", onSelectionImage: nil, offSelectionImage: nil)
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
        collectionView.register(LoansCollegeCollectionViewCell.self, forCellWithReuseIdentifier: collegeCellID)
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
        title = "贷款学院"
        view.backgroundColor = UIColor.white
        topAdBannerView.localImgArray = adverList
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

//MARK: - 数据处理部分
extension LoansCollegeViewController {
    ///获取cell数据
    func getLoansCollegeData(with type: loansCollegeType ,cell: LoansCollegeCollectionViewCell) {
        
        let parameters = ["type": type.rawValue + 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_LoanCollege, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var cellDataArr = [ResourceModel]()
                    for dict in dataArr {
                        cellDataArr.append(ResourceModel(with: dict))
                    }
                    cell.cellArr = cellDataArr
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
extension LoansCollegeViewController: TopAdverViewDelegate {
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
extension LoansCollegeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collegeCellID, for: indexPath) as! LoansCollegeCollectionViewCell
        cell.delegate = self
        cell.type = loansCollegeType(rawValue: indexPath.row)!
        return cell
    }
}

//MARK: - UIScrollView代理
extension LoansCollegeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

//MARK: - LoansCollegeCollectionViewCelld代理
extension LoansCollegeViewController: LoansCollegeCollectionViewCellDelegate {
    func reloadCellData(with cell: LoansCollegeCollectionViewCell) {
        getLoansCollegeData(with: cell.type, cell: cell)
    }
}
