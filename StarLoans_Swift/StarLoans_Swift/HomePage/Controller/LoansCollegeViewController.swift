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
class LoansCollegeViewController: BaseViewController {
    
    //MARK: - 可操作数据
    //MARK: - 懒加载
    ///背景图
    lazy var bgImg: UIImageView = {
        let bgImg = UIImageView()
        self.view.addSubview(bgImg)
        bgImg.contentMode = .scaleAspectFill
        return bgImg
    }()
    
    ///功能栏
    lazy var functionView: FunctionView = { [unowned self] in
        let functionView = FunctionView()
        self.view.addSubview(functionView)
        functionView.delegate = self
        functionView.layer.shadowColor = UIColor.RGB(with: 200, green: 204, blue: 216).cgColor//shadowColor阴影颜色
        functionView.layer.shadowOffset = CGSize(width: 2, height: 0)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        functionView.layer.shadowOpacity = 0.64//阴影透明度，默认0
        functionView.layer.shadowRadius = 4//阴影半径，默认3
        return functionView
        }()
    
    ///分段控制器
//    lazy var segmentView: SMSegmentView = { [unowned self] in
//        let appearance = SMSegmentAppearance()
//        appearance.segmentOnSelectionColour = UIColor.white
//        appearance.segmentOffSelectionColour = UIColor.white
//        appearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 15.0)
//        appearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 15.0)
//        appearance.titleOnSelectionColour = kMainColor
//        appearance.titleOffSelectionColour = kTitleColor
//        appearance.contentVerticalMargin = 10.0
//        appearance.titleGravity = .right
//
//        let segmentView = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 0, segmentAppearance: appearance)
//        self.view.addSubview(segmentView)
//        segmentView.backgroundColor = UIColor.white
//        segmentView.addSegmentWithTitle("新手指引", onSelectionImage: nil, offSelectionImage: nil)
//        segmentView.addSegmentWithTitle("技能培训", onSelectionImage: nil, offSelectionImage: nil)
//        segmentView.addSegmentWithTitle("获客攻略", onSelectionImage: nil, offSelectionImage: nil)
//        segmentView.selectedSegmentIndex = 0
//        segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
//        return segmentView
//        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 130 - 40 - 13)
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
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "贷款学院"
        view.backgroundColor = UIColor.white
        setBasic()
    }
    
    func setBasic() {
        bgImg.image = #imageLiteral(resourceName: "daikxy_bg")
        let imgArr: [UIImage] = [#imageLiteral(resourceName: "guide"), #imageLiteral(resourceName: "training"), #imageLiteral(resourceName: "raiders")]
        let selectImgArr: [UIImage] = [#imageLiteral(resourceName: "guide-selected"), #imageLiteral(resourceName: "training-selected"), #imageLiteral(resourceName: "raiders-selected")]
        let titleArr: [String] = ["新手指引", "技能培训", "获客攻略"]
        functionView.setFuncBtn(imgArr, selectImgArr: selectImgArr, titleArr: titleArr, norColor: kTitleColor, selectColor: kMainColor)
        functionView.selectedBtnIndex(0)
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        bgImg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(130)
        }
        bgImg.layoutIfNeeded()
        
        functionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(bgImg.snp.bottom).offset(-40)
            make.height.equalTo(80)
        }
        functionView.layoutIfNeeded()
        
//        segmentView.snp.makeConstraints { (make) in
//            make.top.left.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: 45))
//        }
//        segmentView.layoutIfNeeded()
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(functionView.snp.bottom).offset(13)
            make.left.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - bgImg.height - functionView.height/2 - 13))
            make.right.bottom.equalToSuperview()
        }
//        collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

//    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
//        let index = IndexPath(item: segmentView.selectedSegmentIndex, section: 0)
//        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//    }
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
            cell.tableView.endHeaderRefresh()
        }
    }
}

extension LoansCollegeViewController: FunctionViewDelegate {
    func buttonDidSelect(at index: Int) {
        collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
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
//            segmentView.selectedSegmentIndex = Int(collectionView.contentOffset.x / kScreenWidth)
            functionView.selectedBtnIndex(Int(collectionView.contentOffset.x / kScreenWidth))
        }
    }
}

//MARK: - LoansCollegeCollectionViewCelld代理
extension LoansCollegeViewController: LoansCollegeCollectionViewCellDelegate {
    func reloadCellData(with cell: LoansCollegeCollectionViewCell) {
        getLoansCollegeData(with: cell.type, cell: cell)
    }
}
