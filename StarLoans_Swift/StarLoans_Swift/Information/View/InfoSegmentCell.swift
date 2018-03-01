//
//  InfoSegmentCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/30.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

enum InformationType: Int {
    case systemInfo = 0         //系统信息
    case transactionsInfo = 1   //交易信息
}

protocol InfoSegmentCellDelegate: class {
    func reloadCellData(with cell: InfoSegmentCell)
    func removeCell(at index: Int)
}

class InfoSegmentCell: UICollectionViewCell {
    //MARK: - 可操作数据
    weak var delegate: InfoSegmentCellDelegate?
    var infoType: InformationType = .systemInfo
    var cellDataArr: [InfoModel] = [InfoModel]()
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        addSubview(tableView)
//        tableView.backgroundColor = kHomeBackColor
        tableView.pan_registerCell(cell: InfoListCell.self)
//        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        tableView.tableFooterView = UIView(frame: .zero)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension InfoSegmentCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as InfoListCell
        cell.setInfoListCellData(with: cellDataArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if infoType == .systemInfo {
            let vc = InfoDetailViewController.loadStoryboard()
            vc.messageId = cellDataArr[indexPath.row].message_id
            let topViewController = Utils.currentTopViewController()
            if topViewController?.navigationController != nil{
                topViewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                topViewController?.present(vc, animated: true , completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.removeCell(at: cellDataArr[indexPath.row].message_id)
            cellDataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
