//
//  CommonProblemViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class CommonProblemViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.white
        tableView.pan_registerCell(cell: CommonProblemCell.self)
//        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
        }()
    
    //MARK: - 内部属性
    fileprivate var problemArr = [UserModel]()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "常见问题"
        tableView.addHeaderRefresh { [weak self] in
            self?.getCommonProblemData()
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
extension CommonProblemViewController {
    func getCommonProblemData() {
//        var parameters = [String: Any]()
        
        NetWorksManager.requst(with: kUrl_QuestionList, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let dataArr = jsonData?["data"].array {
                    var problemDataArr = [UserModel]()
                    for data in dataArr {
                        problemDataArr.append(UserModel(with: data))
                    }
                    self?.problemArr = problemDataArr
                    self?.tableView.reloadData()
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
            self?.tableView.endHeaderRefresh()
        }
    }
}

//MARK: - UITableview代理
extension CommonProblemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return problemArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as CommonProblemCell
        cell.setCommonProblemCellData(problemArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonProblemDetailViewController.loadStoryboard()
        vc.titleText = problemArr[indexPath.row].question
        vc.questionID = problemArr[indexPath.row].question_id
        navigationController?.pushViewController(vc, animated: true)
    }
}
