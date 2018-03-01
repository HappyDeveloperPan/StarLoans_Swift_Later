//
//  MessageCenterViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class MessageCenterViewController: BaseViewController {
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
    
    lazy var topLabel: UILabel = { [unowned self] in
        let topLabel = UILabel()
        self.view.addSubview(topLabel)
        topLabel.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
        topLabel.font = UIFont.systemFont(ofSize: 15)
        topLabel.text = "没有新的系统消息"
        return topLabel
    }()
    
    lazy var topLineView: UIView = { [unowned self] in
        let topLineView = UIView()
        self.view.addSubview(topLineView)
        topLineView.backgroundColor = kHomeBackColor
        return topLineView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth/3 , height: 86)
        layout.minimumLineSpacing = -0.5
        layout.minimumInteritemSpacing = -0.5
        layout.sectionInset = UIEdgeInsets(top: -0.5, left: 0.5, bottom: 0, right: 0.5)
        layout.scrollDirection = .vertical
        return layout
        }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.pan_registerCell(cell: MessageCenterCell.self)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
    //MARK: - 私有数据
    fileprivate let cellDataArr: [Dictionary<String, Any>] = [["image": #imageLiteral(resourceName: "ICON-xitongxiaoxi1"), "content": "系统消息"],
                                                              ["image": #imageLiteral(resourceName: "ICON-pinglunliuyan"), "content": "评论留言"],
                                                              ["image": #imageLiteral(resourceName: "ICON-jingjiren"), "content": "经纪人提醒"]]
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        topLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(45)
        }
        topLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLabel.snp.bottom)
            make.height.equalTo(8)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLineView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func settingBtnClick(_ sender: UIButton) {
        let vc = InfoSettingViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionView代理
extension MessageCenterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.pan_dequeueReusableCell(indexPath: indexPath) as MessageCenterCell
        cell.setMessageCenterCellData(cellDataArr[indexPath.row]["image"] as! UIImage, content: cellDataArr[indexPath.row]["content"] as! String)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = SystemMessageListViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CommentListViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SystemMessageListViewController()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}
