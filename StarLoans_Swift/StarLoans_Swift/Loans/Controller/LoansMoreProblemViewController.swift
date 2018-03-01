//
//  LoansMoreProblemViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class LoansMoreProblemViewController: BaseViewController {

    //MARK: - 懒加载
    lazy var questionBtn: UIButton = { [unowned self] in
        let questionBtn = UIButton()
        self.view.addSubview(questionBtn)
        questionBtn.setTitle("我要提问", for: .normal)
        questionBtn.setTitleColor(UIColor.white, for: .normal)
        questionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        questionBtn.backgroundColor = kMainColor
        questionBtn.addTarget(self, action: #selector(questionBtnClick(_:)), for: .touchUpInside)
        return questionBtn
    }()
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.pan_registerCell(cell: ProblemCell.self)
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    lazy var formatter: DateFormatter = { [unowned self] in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //MARK: - 可操作数据
    var productId: Int = 0
    var cellDataArr: [QuestionModel] = [QuestionModel]()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更多问题"
        tableView.addHeaderRefresh { [weak self] in
            self?.getQuestionListData()
        }
        tableView.beginHeaderRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        questionBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(49)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(questionBtn.snp.top)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func questionBtnClick(_ sender: UIButton) {
        let vc = LoansQuestionsViewController()
        vc.productId = productId
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoansMoreProblemViewController {
    ///获取问题列表数据
    func getQuestionListData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["product_id"] = productId
        parameters["page"] = 1
        NetWorksManager.requst(with: kUrl_ProductQuestionList, type: .post, parameters: parameters) { [weak self](jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var cellDataArr = [QuestionModel]()
                    for dict in data {
                        cellDataArr.append(QuestionModel(with: dict))
                    }
                    self?.cellDataArr = cellDataArr
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

//MARK: - UITableView代理
extension LoansMoreProblemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as ProblemCell
        cell.setProblemCellData(cellDataArr[indexPath.row], formatter: formatter)
        return cell
    }
}
