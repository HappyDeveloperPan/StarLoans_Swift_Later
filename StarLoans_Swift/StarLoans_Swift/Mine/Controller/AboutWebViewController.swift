//
//  AboutWebViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/2/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import WebKit

class AboutWebViewController: BaseViewController {
    //MARK: - 对外属性
//    var url: String = ""
    
    //MARK: - 内部属性
    fileprivate lazy var webView: WKWebView = { [unowned self] in
        let webView = WKWebView()
        self.view.addSubview(webView)
        return webView
        }()

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
//        if url.judgeURL() {
//            webView.load(URLRequest(url: URL(string: url)!))
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        webView.snp.makeConstraints { (make) in
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
