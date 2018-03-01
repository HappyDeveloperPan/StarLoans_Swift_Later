//
//  HotNewsListViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/2/6.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class HotNewsListViewController: BaseViewController {
    //MARK: - 内部属性
    var newsDataArr = [ResourceModel]()
    
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.pan_registerCell(cell: MessageTableViewCell.self)
        return tableView
        }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "热门新闻"
        tableView.addHeaderRefresh { [weak self] in
            self?.getNewsData()
        }
        tableView.beginHeaderRefresh()
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

//MARK: - 数据处理
extension HotNewsListViewController {
    ///获取新闻列表数据
    func getNewsData() {
        var parameters = [String: Any]()
        parameters["key"] = NewsAppKey
        parameters["type"] = "caijing"
        NetWorksManager.requst(with: kUrl_HotNews, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["result"]["stat"].intValue == 1 {
                if let dataArr = jsonData?["result"]["data"].array {
                    var newsArr = [ResourceModel]()
                    for data in dataArr {
                        newsArr.append(ResourceModel(with: data))
                    }
                    self?.newsDataArr = newsArr
                    self?.tableView.reloadData()
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["reason"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
            self?.tableView.endHeaderRefresh()
        }
    }
}

//MARK: - UITableView代理
extension HotNewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as MessageTableViewCell
        cell.setHotNewsData(newsDataArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ActivityCenterViewController()
        vc.url = newsDataArr[indexPath.row].url
        vc.title = "热点新闻"
        navigationController?.pushViewController(vc, animated: true)
    }
}
