//
//  CommonProblemDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/2/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class CommonProblemDetailViewController: BaseViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    //MARK: - 外部属性
    var titleText: String = ""
    var questionID: Int = 0
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "问题详情"
        titleLB.text = titleText
        getProblemDeta()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CommonProblemDetailViewController {
    func getProblemDeta() {
        var parameters = [String: Any]()
        parameters["question_id"] = questionID
        NetWorksManager.requst(with: kUrl_QuestionInfo, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    let userModel = UserModel(with: data)
                    self?.contentLB.text = userModel.answer
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
        }
    }
}
