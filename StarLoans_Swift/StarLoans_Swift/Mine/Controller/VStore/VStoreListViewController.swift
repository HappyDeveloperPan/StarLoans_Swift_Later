//
//  VStoreListViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/6.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class VStoreListViewController: UIViewController {
    //MARK: - 外部属性
    var storeType: VStoreType = .broker
    //MARK: - 懒加载
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: 160)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        return layout
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = kHomeBackColor
        collectionView.pan_registerCell(cell: ManagerBillCell.self)
        collectionView.pan_registerCell(cell: BrokerClientCell.self)
        collectionView.pan_registerCell(cell: ProductDetailCollectionViewCell.self)
        collectionView.pan_registerCell(cell: HotResourceCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kHomeBackColor
        getVStoreListData()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: - 数据处理
extension VStoreListViewController {
    ///获取微店订单数据
    func getVStoreListData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["page"] = 1
        parameters["order_type"] = 1
        NetWorksManager.requst(with: kUrl_ManagerOrderList, type: .post, parameters: parameters) { (jsonData, error) in
            if jsonData?["status"] == 200 {
                
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
extension VStoreListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if storeType == .manager {
            let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as ManagerBillCell
            return cell
        }else {
            let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as HotResourceCell
            return cell
        }
    }
}
