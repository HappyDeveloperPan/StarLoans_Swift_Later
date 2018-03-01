//
//  WelcomeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/23.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: - 懒加载
    lazy var mainView: UIScrollView = { [unowned self] in
        let mainView = UIScrollView()
        self.view.addSubview(mainView)
        mainView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        mainView.showsVerticalScrollIndicator = false
        mainView.showsHorizontalScrollIndicator = false
        mainView.bounces = false
        mainView.isPagingEnabled = true
        mainView.scrollsToTop = false
        if #available(iOS 11.0, *) {
            mainView.contentInsetAdjustmentBehavior = .never
        }
        mainView.delegate = self
        
        for index in 0...imagesArr.count-1 {
            let imageView = UIImageView()
            mainView.addSubview(imageView)
            imageView.image = imagesArr[index]
            imageView.contentMode = .scaleAspectFill
            imageView.tag = index + 10
        }
        
        return mainView
        }()
    
    lazy var pageControl: UIPageControl = { [unowned self] in
        let pageControl = UIPageControl()
        self.view.addSubview(pageControl)
        pageControl.numberOfPages = self.imagesArr.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = kMainColor
        return pageControl
    }()
    
    lazy var startButton: UIButton = { [unowned self] in
        let startButton = UIButton(type: .custom)
        self.view.addSubview(startButton)
        startButton.setTitle("立即体验", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = kMainColor
        startButton.layer.cornerRadius = 22.5
        startButton.alpha = 0
        startButton.addTarget(self, action: #selector(startButtonClick(_:)), for: .touchUpInside)
        return startButton
    }()
    
    //MARK: - 内部属性
    fileprivate let imagesArr: [UIImage] = [#imageLiteral(resourceName: "1125_2436-1"), #imageLiteral(resourceName: "1125_2436-2"), #imageLiteral(resourceName: "1125_2436-3")]

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        for index in 0...imagesArr.count-1 {
            let imageView = view.viewWithTag(index + 10)
            imageView?.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.left.equalTo(kScreenWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight))
                if index == imagesArr.count - 1 {
                    make.right.equalToSuperview()
                }
            })
        }
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-(kStatusHeight + 20))
        }
        
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 160, height: 45))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("视图销毁了")
    }
    
    @objc func startButtonClick(_ sender: UIButton) {
        self.view.window?.rootViewController = AXDTabBarViewController()
    }

}

extension WelcomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / kScreenWidth)
        if pageControl.currentPage == imagesArr.count - 1 {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.startButton.alpha = 1
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.startButton.alpha = 0
            })
        }
    }
}
