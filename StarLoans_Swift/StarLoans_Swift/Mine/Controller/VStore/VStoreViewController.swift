//
//  VStoreViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let managerFuncArr: [String] = ["待受理", "待反馈", "待审批", "待放款", "未通过", "已完成"]
fileprivate let brokerFuncArr: [String] = ["已代理客户", "已发产品", "收到交单", "已购资源", "已发资源", "已完成"]

enum VStoreType {
    case manager
    case broker
}

class VStoreViewController: BaseViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var headIMg: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userTypeLB: UILabel!
    @IBOutlet weak var makeMoneyLB: UILabel!
    @IBOutlet weak var loanLB: UILabel!
    @IBOutlet weak var funcView: UIView!
    
    //MARK: - 外部属性
    var storeType: VStoreType = .broker
    
    //MARK: - 内部属性
    fileprivate var VStoreModel = UserModel()
    fileprivate var orderArr = [Int]()
    
    //MARK: - 懒加载
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth/3 , height: 86)
        layout.minimumLineSpacing = -0.5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.funcView.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.pan_registerCell(cell: VStoreFuncCollectionViewCell.self)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "微店订单"
        setupBasic()
        setupBasicData()
        getVStoreData()
    }
    
    func setupBasic() {
        userTypeLB.layer.backgroundColor = kMainColor.cgColor
        userTypeLB.layer.cornerRadius = userTypeLB.height/2
    }
    
    func setupBasicData() {
        if UserManager.shareManager.userModel.type == 1 {
            storeType = .broker
            userTypeLB.text = "经纪人"
        }
        if UserManager.shareManager.userModel.type == 2 {
            storeType = .manager
            userTypeLB.text = "机构经理"
        }
        if UserManager.shareManager.userModel.type == 3 {
            storeType = .broker
            userTypeLB.text = "信贷经理"
        }
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

    @IBAction func moreBtnClick(_ sender: UIButton) {
        let vc = VStoreSegmentViewController()
        vc.storeType = storeType
        vc.selectedSegmentIndex = 0
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - VStoreViewController {
extension VStoreViewController {
    ///获取微店订单数据
    func getVStoreData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        NetWorksManager.requst(with: kUrl_ManagerHomePage, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    self?.VStoreModel = UserModel(with: data)
                    self?.orderArr.append((self?.VStoreModel.waitHandle)!)
                    self?.orderArr.append((self?.VStoreModel.waitFeedback)!)
                    self?.orderArr.append((self?.VStoreModel.waitApprove)!)
                    self?.orderArr.append((self?.VStoreModel.waitPay)!)
                    self?.orderArr.append((self?.VStoreModel.noPass)!)
                    self?.orderArr.append((self?.VStoreModel.finish)!)
                    self?.collectionView.reloadData()
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
        }
    }
}

//MARK: - UICollectionView代理
extension VStoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as VStoreFuncCollectionViewCell
        if storeType == .broker {
            cell.titleLB.text = brokerFuncArr[indexPath.row]
            if orderArr.count == 6 {
                cell.contentLB.text = String(orderArr[indexPath.row])
            }
        }
        if storeType == .manager {
            cell.titleLB.text = managerFuncArr[indexPath.row]
            if orderArr.count == 6 {
                cell.contentLB.text = String(orderArr[indexPath.row])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VStoreSegmentViewController()
        vc.storeType = storeType
        vc.segmentIndex = indexPath.row + 1
        navigationController?.pushViewController(vc, animated: true)
    }
}

