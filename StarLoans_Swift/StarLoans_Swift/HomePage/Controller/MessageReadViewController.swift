//
//  MessageReadViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/22.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

enum MessageReadType: Int {
    case businessHot = 0
    case financeLaws = 1
    case newPlayingMetPhod = 2
}

fileprivate let cellID = "MessageReadCell"

class MessageReadViewController: BaseViewController {
    //MARK: - 懒加载
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
        segmentView.layer.borderColor = UIColor(white: 0.75, alpha: 1.0).cgColor
        segmentView.layer.borderWidth = 0.5
        segmentView.addSegmentWithTitle("行业热门", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("金融法规", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.addSegmentWithTitle("新玩法", onSelectionImage: nil, offSelectionImage: nil)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentView
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 45)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.register(MessageReadCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = UIColor.white
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
        title = "资讯研读"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        segmentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 45))
        }
        segmentView.layoutIfNeeded()
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 45))
        }
        collectionView.layoutIfNeeded()
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
extension MessageReadViewController {
    ///获取cell数据
    func getMessageReadData(with type: MessageReadType ,cell: MessageReadCell) {
        
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
//                var cellArr = [MessageReadModel]()
//                for dict in (jsonData?["data"].array)! {
//                    cellArr.append(MessageReadModel(with: dict))
//                }
//                cell.cellArr = cellArr
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
}

//MARK: - UICollectionView代理
extension MessageReadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MessageReadCell
        cell.delegate = self
        cell.type = MessageReadType(rawValue: indexPath.row)!
        return cell
    }
}

//MARK: - UIScrollView代理
extension MessageReadViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
        }
    }
}

extension MessageReadViewController: MessageReadCellDelegate {
    func reloadCellData(with cell: MessageReadCell) {
        getMessageReadData(with: cell.type, cell: cell)
    }
}
