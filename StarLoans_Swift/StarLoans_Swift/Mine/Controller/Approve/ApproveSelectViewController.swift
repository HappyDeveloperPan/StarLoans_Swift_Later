//
//  ApproveSelectViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let approveSelectArr: [Dictionary<String, Any>] = [
                                                               ["title": "经纪人", "content": "海量资源和一站式贷款服务",      "image": #imageLiteral(resourceName: "ICON-jinjiren")],
                                                               ["title": "平台信贷经理", "content": "更多的资源、更便捷的交单", "image": #imageLiteral(resourceName: "ICON-pingtaixindaijingli")],
                                                               ["title": "银行机构经理", "content": "审批标准化、透明化", "image": #imageLiteral(resourceName: "ICON-yinhangjigoujingli")]]

class ApproveSelectViewController: BaseViewController, StoryboardLoadable {
    //MARK: - 懒加载
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth - 32, height: 130)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        layout.footerReferenceSize = CGSize(width: kScreenWidth, height: 200)
        return layout
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.pan_registerCell(cell: ApproveSelectCell.self)
        collectionView.register(ApproveSelectFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ApproveSelectFooterView")
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "身份选择"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ApproveSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return approveSelectArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as ApproveSelectCell
        cell.titleLB.text = approveSelectArr[indexPath.row]["title"] as? String
        cell.contentLB.text = approveSelectArr[indexPath.row]["content"] as? String
        cell.backImg.image = approveSelectArr[indexPath.row]["image"] as? UIImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var footerView:UICollectionReusableView?
        if kind == UICollectionElementKindSectionFooter {
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ApproveSelectFooterView", for: indexPath)
        }
        return footerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.1, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (finish) in
            UIView.animate(withDuration: 0.1, animations: {
                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { [weak self] (finish) in
                if UserManager.shareManager.userModel.is_audit == 2 {
                    JSProgress.showInfoWithStatus(with: "正在审核中")
                    return
                }
                
                switch indexPath.row {
                case 0:
                    let vc = IDApproveViewController.loadStoryboard()
                    vc.approveType = .brokerIdentity
                    self?.navigationController?.pushViewController(vc, animated: true)
                case 1:
                    let vc = LoanManagerApproveViewController.loadStoryboard()
                    self?.navigationController?.pushViewController(vc, animated: true)
                case 2:
                    let vc = IDApproveViewController.loadStoryboard()
                    vc.approveType = .managerIdentity
                    self?.navigationController?.pushViewController(vc, animated: true)
                default: break
                }
            }
        }
    }
}
