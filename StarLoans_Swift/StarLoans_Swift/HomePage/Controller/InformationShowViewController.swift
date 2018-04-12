//
//  InformationShowViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/2/7.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import WebKit

class InformationShowViewController: BaseViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var formLB: UILabel!
    @IBOutlet weak var readNumLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    //MARK: - 外部属性
    var resourceModel = ResourceModel()
    
    //MARK: - 懒加载
    lazy var webView: WKWebView = { [unowned self] in
        let webView = WKWebView()
        self.view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.uiDelegate = self
        webView.navigationDelegate = self
//        webView.scrollView.delegate = self
        return webView
    }()
    
    lazy var progressView: UIProgressView = { [unowned self] in
        let progressView = UIProgressView()
        progressView.progressTintColor = kMainColor
        progressView.trackTintColor = UIColor.white
        self.view.addSubview(progressView)
        return progressView
    }()
    
    lazy var bottomLb: UILabel = { [unowned self] in
        let bottomLb = UILabel()
        bottomLb.text = "成功吧"
        bottomLb.textColor = UIColor.white
        bottomLb.backgroundColor = kMainColor
        self.view.addSubview(bottomLb)
        return bottomLb
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicData()
        if resourceModel.url.judgeURL() {
            webView.load(URLRequest(url: URL(string: resourceModel.url)!))
        }
//        webView.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(socializeShare))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ICON-comback"), style: .plain, target: self, action: #selector(backItemPressed))
    }
    
    func setBasicData() {
        titleLB.text = resourceModel.title
        readNumLB.text = String(resourceModel.reading_number)
        formLB.text = resourceModel.coming_from
        timeLB.text = resourceModel.time
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(formLB.snp.bottom).offset(16)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
//        progressView.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    
    /// 根据网页的层级进行返回操作
    @objc func backItemPressed() {
        if webView.canGoBack {
            webView.goBack()
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - 数据处理
extension InformationShowViewController {
    @objc func socializeShare() {
        let shareView = QSShareView()
        let shareModel = QSShareModel()
        shareModel.title = resourceModel.title
        shareModel.descr = resourceModel.title
        shareModel.image = resourceModel.thumbnail_pic_s
        shareModel.url = resourceModel.url
        shareView.showShareView(with: shareModel, shareContentType: .QSShareContentTypeText)
    }
}

//MARK: - WKWebView代理
extension InformationShowViewController: WKUIDelegate, WKNavigationDelegate, UINavigationControllerDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}

//MARK: - WKWebView滑动代理
//extension InformationShowViewController: UIScrollViewDelegate {
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("contentY=\(scrollView.contentOffset.y),contentH=\(scrollView.contentSize.height)")
//    }
//}

