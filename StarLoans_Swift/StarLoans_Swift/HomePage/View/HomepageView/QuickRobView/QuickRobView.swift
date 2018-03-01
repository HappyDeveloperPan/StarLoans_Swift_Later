//
//  QuickRobView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/6.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let robbingCell: String = "RobbingTableViewCell"
fileprivate let ceshiCell: String = "CheshiTableViewCell"

protocol QuickRobViewDelegate: class {
    func moreQuickBill()
}

class QuickRobView: UIView {
    weak var delegate: QuickRobViewDelegate?
    //MARK: - 可操作数据
    var cellArr: [ClientInfoModel] = [ClientInfoModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    //MARK: - 懒加载
    lazy var topMoreBtn: UIButton = { [unowned self] in
        let topMoreBtn = UIButton()
        addSubview(topMoreBtn)
        topMoreBtn.backgroundColor = UIColor.white
        topMoreBtn.setTitle("急速抢单>", for: .normal)
        topMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        topMoreBtn.setTitleColor(UIColor.RGB(with: 51, green: 51, blue: 51), for: .normal)
        topMoreBtn.setImage(#imageLiteral(resourceName: "ICON-jisuqiangdan"), for: .normal)
        topMoreBtn.addTarget(self, action: #selector(topMoreBtnClick(_:)), for: .touchUpInside)
        return topMoreBtn
        }()
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        addSubview(tableView)
        tableView.backgroundColor = kHomeBackColor
        tableView.register(UINib(nibName: robbingCell, bundle: nil), forCellReuseIdentifier: robbingCell)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = kHomeBackColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        topMoreBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topMoreBtn.snp.bottom)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 338))
        }
    }
    
    @objc func topMoreBtnClick(_ sender: UIButton) {
        delegate?.moreQuickBill()
//        let vc = QuickRobbingViewController()
//        let topViewController = Utils.currentTopViewController()
//        if topViewController?.navigationController != nil{
//            topViewController?.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            topViewController?.present(vc, animated: true , completion: nil)
//        }
    }
}

//MARK: - UITableView代理
extension QuickRobView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    //iOS11以后不实现会造成间距无法显示
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: robbingCell, for: indexPath) as! RobbingTableViewCell
        cell.setQuickRobData(with: cellArr[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = QuickBillDetailViewController.loadStoryboard()
        vc.clientModel = cellArr[indexPath.row]
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}
