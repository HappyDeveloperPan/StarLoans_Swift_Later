//
//  InputUserInfoWebViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/26.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import WebKit

class InputUserInfoWebViewController: BaseViewController {
    
    //MARK: - 对外属性
    var productId: Int = 0
    var loansProductType: LoansProductType = .selfSupport //产品类别
    var loanClientType: LoanClientType = .personage //用户类别
    var url: String = ""
    
    //MARK: - 内部属性
    ///nav栏
    fileprivate weak var navController: UINavigationController?
    
    //MARK: - 懒加载
    fileprivate lazy var webView: WKWebView = { [unowned self] in
        //准备工作,初始化 webview 的设置
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        //注册监听JS的消息发送
        userContentController.add(self, name: "startParams")            //发送数据给js
        userContentController.add(self, name: "backVC")                 //返回上一个界面
        userContentController.add(self, name: "uploadPictures")         //获取原生图片
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        self.view.addSubview(webView)
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    fileprivate lazy var progressView: UIProgressView = { [unowned self] in
        let progressView = UIProgressView()
        progressView.progressTintColor = kMainColor
        progressView.trackTintColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(progressView)
        return progressView
        }()
    
    lazy var leftButton: UIButton = { [unowned self] in
        let leftButton = UIButton()
        leftButton.setImage(#imageLiteral(resourceName: "ICON-comback"), for: .normal)
        return leftButton
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ICON-comback"), style: .plain, target: self, action: #selector(backItemPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(backVC))
        if url.judgeURL() {
            webView.load(URLRequest(url: URL(string: url)!))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
//        navigationController?.delegate = self
//        navController = navigationController
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        progressView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
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
        
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}

//MARK: - 数据处理
extension InputUserInfoWebViewController {
    //MARK: - JS调用原生方法
    ///JS调取原生相机
    func uploadPictures() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectOne = UIAlertAction(title: "拍照", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.camera
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                self?.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else {
                JSProgress.showFailStatus(with: "相机不可用")
            }
        }
        let selectTwo = UIAlertAction(title: "从手机相册选择", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                self?.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else {
                JSProgress.showFailStatus(with: "相册不可访问")
            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(selectOne)
        alertController.addAction(selectTwo)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - 原生回调JS方法
    ///H5页面调用接口所需要数据
    func portDataSendToJs() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["pid"] = productId
        parameters["location"] = UserManager.shareManager.userModel.location
        let baseStr = "portDataSendToJS('\(String(describing: parameters))')"
        webView.evaluateJavaScript(baseStr, completionHandler: nil)
    }
    
    ///图片数据回传给JS
    func pictureDataSendToJs(_ image: UIImage) {
        let pictureData = UIImageJPEGRepresentation(image, 0.5)?.base64EncodedString()
        if let pictureStr = pictureData {
            let baseStr = "sendPictureDataToJS('\(String(describing: pictureStr))')"
            webView.evaluateJavaScript(baseStr, completionHandler: nil)
        }
//        let baseStr = "sendPictureDataToJS('\(String(describing: pictureData!))')"
//        webView.evaluateJavaScript(baseStr, completionHandler: nil)
    }
    
    ///返回上一级网页
    @objc func goBackOnePage() {
        let baseStr = "goBackOnePage()"
        webView.evaluateJavaScript(baseStr, completionHandler: nil)
    }
    
    
    //MARK: - 原生方法
    ///根据网页是否有上一级页面跳转
    @objc func backItemPressed() {
        if webView.canGoBack {
            webView.goBack()
        }else {
            backVC()
        }
    }
    
    ///原生返回上一级界面
    @objc func backVC() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - 系统相册代理
extension InputUserInfoWebViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        pictureDataSendToJs(image)
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

//MARK: - WKWebView代理
extension InputUserInfoWebViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //方法名
        print(message.name)
        //参数
        print(message.body)
        //根据方法名调起不同的功能
        if message.name == "startParams" {
            portDataSendToJs()
        }
        if message.name == "backVC" {
            backVC()
        }
        if message.name == "uploadPictures" {
            uploadPictures()
        }
    }
}

//MARK: - UINavigationController代理
//extension InputUserInfoWebViewController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if viewController == self {
//            navController?.setNavigationBarHidden(true, animated: animated)
//        }
//        else {
//            //不在本页时，显示真正的nav bar
//            navController?.setNavigationBarHidden(false, animated: animated)
//            //当不显示本页时，要么就push到下一页，要么就被pop了，那么就将delegate设置为nil，防止出现BAD ACCESS
//            //之前将这段代码放在viewDidDisappear和dealloc中，这两种情况可能已经被pop了，self.navigationController为nil，这里采用手动持有navigationController的引用来解决
//            if navController?.delegate === self  {
//                //如果delegate是自己才设置为nil，因为viewWillAppear调用的比此方法较早，其他controller如果设置了delegate就可能会被误伤
//                navController?.delegate = nil
//            }
//        }
//    }
//}

