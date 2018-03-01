//
//  MoneyDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/18.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MoneyDetailViewController: UIViewController {
    
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.backgroundColor = UIColor.white
        tableView.pan_registerCell(cell: MoneyDetailTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "明细"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        (navigationController as? AXDNavigationController)?.navBarHairlineImageView?.isHidden = false
    }

    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(animated)
        (navigationController as? AXDNavigationController)?.navBarHairlineImageView?.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MoneyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as MoneyDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
