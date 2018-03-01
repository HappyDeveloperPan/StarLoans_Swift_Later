//
//  CommentListViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class CommentListViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.pan_registerCell(cell: CommentMessageCell.self)
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
        }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "评论留言"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - UITableView代理
extension CommentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as CommentMessageCell
        //        cell.setProblemCellData(cellDataArr[indexPath.row], formatter: formatter)
        return cell
    }
}
