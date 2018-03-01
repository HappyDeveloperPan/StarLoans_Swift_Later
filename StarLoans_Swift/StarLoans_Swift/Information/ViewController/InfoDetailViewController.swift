//
//  InfoDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class InfoDetailViewController: BaseViewController, StoryboardLoadable {
    @IBOutlet weak var userImg: AnimatableImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var questionLB: UILabel!
    @IBOutlet weak var answerTV: MyTextView!
    
    //MARK: - 可操作数据
    var messageId: Int = 0
    var infoModel: InfoModel = InfoModel()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "问题详情"
        setupBasic()
        getInfoDetailData()
    }
    
    func setupBasic() {
//        userImg.layer.masksToBounds = true
        questionLB.numberOfLines = 0
        questionLB.sizeToFit()
        answerTV.placeholder = "请输入回答..."
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
        // Dispose of any resources that can be recreated.
    }
    @IBAction func commitBtnClick(_ sender: UIButton) {
        
        guard !answerTV.text.isEmpty else {
            JSProgress.showFailStatus(with: "请输入回答")
            return
        }
        
        JSProgress.showBusy()
        
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["question_id"] = infoModel.question_id
        parameters["answer"] = answerTV.text
        NetWorksManager.requst(with: kUrl_QuestionAnswer, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                self?.navigationController?.popViewController(animated: true)
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

extension InfoDetailViewController {
    ///获取问题详情数据
    func getInfoDetailData() {
        
        JSProgress.showBusy()
        
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["message_id"] = messageId
        NetWorksManager.requst(with: kUrl_InfoDetail, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    self?.infoModel = InfoModel(with: data)
                    self?.updateInfoDetailData()
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
    
    func updateInfoDetailData() {
        if !infoModel.questioner_tx.isEmpty {
//            userImg.setImage(with: infoModel.questioner_tx)
            userImg.setImage(infoModel.questioner_tx, placeholder: nil, completionHandler: { [weak self] (image, error, cacheType, url) in
                self?.userImg.circleImage()
            })
        }
        userNameLB.text = infoModel.questioner_user
        timeLB.text = Utils.getDateToYMD(with: infoModel.question_time)
        questionLB.text = "问：" + infoModel.question_title
    }
}
