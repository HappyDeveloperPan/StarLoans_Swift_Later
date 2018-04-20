//
//  VideoCenterViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/14.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellID = "VideoCenterCollectionViewCell"

enum VideoType: Int {
    case hotVideo = 0
    case productVideo = 1
    case showVideo = 2
}

class VideoCenterViewController: BaseViewController {
    
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
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 130 - 40 - 13)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCenterCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
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
        title = "视频中心"
        self.view.backgroundColor = UIColor.white
        setBasic()
    }
    
    func setBasic() {
        bgImg.image = #imageLiteral(resourceName: "shipzx_bg")
        let imgArr: [UIImage] = [#imageLiteral(resourceName: "remsh"), #imageLiteral(resourceName: "changpsp"), #imageLiteral(resourceName: "luysp")]
        let selectImgArr: [UIImage] = [#imageLiteral(resourceName: "remsh_selected"), #imageLiteral(resourceName: "changpsp_selected"), #imageLiteral(resourceName: "luysp_selected")]
        let titleArr: [String] = ["热门视频", "产品视频", "路演视频"]
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
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(functionView.snp.bottom).offset(13)
            make.left.right.bottom.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - 数据处理部分
extension VideoCenterViewController {
    ///获取cell数据
    func getVideoData(with type: VideoType ,cell: VideoCenterCollectionViewCell) {
        
        let parameters = ["video_type": type.rawValue + 1,
                          "page": 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_VideoCenter, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                
                if let dataArr = jsonData?["data"].array {
                    var cellDataArr = [VideoModel]()
                    for dict in dataArr {
                        cellDataArr.append(VideoModel(with: dict))
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

extension VideoCenterViewController: FunctionViewDelegate {
    func buttonDidSelect(at index: Int) {
        collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
    }
}

//MARK: - UICollectionView代理
extension VideoCenterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VideoCenterCollectionViewCell
        cell.delegate = self
        cell.type = VideoType(rawValue: indexPath.row)!
        return cell
    }
}

//MARK: - UIScrollView代理
extension VideoCenterViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            functionView.selectedBtnIndex(Int(collectionView.contentOffset.x / kScreenWidth))
        }
    }
}

extension VideoCenterViewController: VideoCenterCellDelegate {
    func reloadCellData(with cell: VideoCenterCollectionViewCell) {
        getVideoData(with: cell.type, cell: cell)
    }
}

