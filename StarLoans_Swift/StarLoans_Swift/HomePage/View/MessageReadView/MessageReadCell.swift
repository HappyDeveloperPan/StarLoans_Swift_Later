//
//  MessageReadCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/22.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

protocol MessageReadCellDelegate: class {
    func reloadCellData(with cell: MessageReadCell)
}

class MessageReadCell: UICollectionViewCell{
    //MARK: - 可操作数据
    weak var delegate: MessageReadCellDelegate?
    var type: MessageReadType = .businessHot
    var cellArr: [ResourceModel] = [ResourceModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        addSubview(tableView)
        tableView.backgroundColor = UIColor.white
        tableView.pan_registerCell(cell: MessageTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        tableView.addHeaderRefresh { [weak self] in
            self?.delegate?.reloadCellData(with: self!)
        }
        tableView.beginHeaderRefresh()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight - kNavHeight - 45))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageReadCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as MessageTableViewCell
        cell.setMessageReadData(with: cellArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InformationShowViewController.loadStoryboard()
        vc.title = "资讯详情"
        vc.resourceModel = cellArr[indexPath.row]
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
