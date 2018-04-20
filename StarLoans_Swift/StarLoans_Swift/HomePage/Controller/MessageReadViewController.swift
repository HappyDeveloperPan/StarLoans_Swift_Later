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
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "资讯研读"
        setBasic()
    }
    
    func setBasic() {
        bgImg.image = #imageLiteral(resourceName: "zixyd_bg")
        let imgArr: [UIImage] = [#imageLiteral(resourceName: "xinwzx"), #imageLiteral(resourceName: "fanlcg"), #imageLiteral(resourceName: "xinwf")]
        let selectImgArr: [UIImage] = [#imageLiteral(resourceName: "xinwzx_selected"), #imageLiteral(resourceName: "fanlcg_selected"), #imageLiteral(resourceName: "xinwf-_selected")]
        let titleArr: [String] = ["行业热门", "金融法规", "新玩法"]
        functionView.setFuncBtn(imgArr, selectImgArr: selectImgArr, titleArr: titleArr, norColor: kTitleColor, selectColor: kMainColor)
        functionView.selectedBtnIndex(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
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
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - 数据处理部分
extension MessageReadViewController {
    ///获取cell数据
    func getMessageReadData(with type: MessageReadType ,cell: MessageReadCell) {
        
        let parameters = ["type": type.rawValue + 1] as [String: Any]
        
        NetWorksManager.requst(with: kUrl_InfoStudying, type: .post, parameters: parameters) { (jsonData, error) in
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

extension MessageReadViewController: FunctionViewDelegate {
    func buttonDidSelect(at index: Int) {
        collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
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
            functionView.selectedBtnIndex(Int(collectionView.contentOffset.x / kScreenWidth))
        }
    }
}

extension MessageReadViewController: MessageReadCellDelegate {
    func reloadCellData(with cell: MessageReadCell) {
        getMessageReadData(with: cell.type, cell: cell)
    }
}
