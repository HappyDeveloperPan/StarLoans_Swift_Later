//
//  LoansQuestionsViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class LoansQuestionsViewController: BaseViewController {
    
    //MARK: - 懒加载
    lazy var textView: MyTextView = { [unowned self] in
        let textView = MyTextView()
        self.view.addSubview(textView)
        textView.placeholder = "请输入问题（200字以内）"
        textView.backgroundColor = kHomeBackColor
        textView.placeHolderLabel?.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    lazy var commitBtn: UIButton = { [unowned self] in
        let commitBtn = UIButton()
        self.view.addSubview(commitBtn)
        commitBtn.setTitle("提交", for: .normal)
        commitBtn.setTitleColor(UIColor.white, for: .normal)
        commitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        commitBtn.backgroundColor = kMainColor
        commitBtn.layer.cornerRadius = 22.5
        commitBtn.addTarget(self, action: #selector(commitBtnClick(_:)), for: .touchUpInside)
        return commitBtn
    }()
    
    //MARK: - 可操作数据
    var productId: Int = 0
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提问"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.right.equalTo(16)
            make.height.equalTo(200)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 45))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func commitBtnClick(_ sender: UIButton) {
        guard textView.text.lengthOfBytes(using: .utf8) > 0 else {
            JSProgress.showFailStatus(with: "请输入问题")
            return
        }
        guard textView.text.lengthOfBytes(using: .utf8) <= 200 else {
            JSProgress.showFailStatus(with: "字数超过200")
            return
        }
        
        JSProgress.showBusy()
        
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["product_id"] = productId
        parameters["question"] = textView.text
        NetWorksManager.requst(with: kUrl_QuestionAsk, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            
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
