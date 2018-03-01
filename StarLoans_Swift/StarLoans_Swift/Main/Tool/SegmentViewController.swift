//
//  ViewController.swift
//  仿网易scrollView
//
//  Created by 张海峰 on 2017/8/10.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import UIKit

class SegmentViewController: BaseViewController {
    //MARK: - 懒加载
    lazy var titleScrollView: UIScrollView = { [unowned self] in
        let titleScrollView = UIScrollView()
        self.view.addSubview(titleScrollView)
        if #available(iOS 11.0, *) {
            titleScrollView.contentInsetAdjustmentBehavior = .never
        }
        return titleScrollView
    }()
    lazy var contentScrollView: UIScrollView = { [unowned self] in
        let contentScrollView = UIScrollView()
        contentScrollView.delegate=self
        contentScrollView.isPagingEnabled = true
        contentScrollView.bounces = false
        self.view.addSubview(contentScrollView)
        return contentScrollView
    }()
    lazy var bottomLine: UIView = { [unowned self] in
        let bottomLine = UIView()
        self.titleScrollView.addSubview(bottomLine)
        bottomLine.backgroundColor = onSelectColor
        return bottomLine
    }()
    //MARK: - 可操作数据
    var radioBtn :UIButton = UIButton()
    lazy var titleBtns : NSMutableArray = NSMutableArray()
    var selectedSegmentIndex: Int = 0
    var isInitalize : Bool = false
    var onSelectColor: UIColor = kMainColor
    var offSelectColor: UIColor = kTitleColor
    var titleFont: CGFloat = 15
    var titleWidth: CGFloat = 80
    fileprivate var contentOffsetX: CGFloat = 0
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "网易新闻"
        self.automaticallyAdjustsScrollViewInsets = false
        
//        bottomLine.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.bottom.equalTo(-2)
//            make.height.equalTo(2)
//            make.width.equalTo(100)
//        }
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        titleScrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(45)
        }
        titleScrollView.layoutIfNeeded()
        contentScrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleScrollView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        contentScrollView.layoutIfNeeded()
        if (isInitalize == false) {
            //4.设置所有的标题
            setupAllTitle()
            isInitalize = true
//            bottomLine.snp.updateConstraints { (make) in
//                make.left.equalTo(0)
//                make.top.equalTo(titleScrollView.bounds.size.height-2)
//                make.height.equalTo(2)
//                make.width.equalTo(100)
//            }
        }
    }
    
    
}

//MARK:-  设置UI
extension SegmentViewController:UIScrollViewDelegate{
    func setupAllTitle() {
        let count :NSInteger = self.childViewControllers.count;
        let btnW :CGFloat = titleWidth
        let btnH :CGFloat = self.titleScrollView.bounds.size.height-2
        var btnX :CGFloat = 0
        for i in 0 ..< count {
            let titleBtn :UIButton = UIButton.init(type:UIButtonType.custom)
            let VC :UIViewController =  self.childViewControllers[i]
            titleBtn.setTitle(VC.title, for: UIControlState.normal)
            btnX = CGFloat(i) * btnW
            titleBtn.tag = i
            titleBtn.setTitleColor(offSelectColor, for: UIControlState.normal)
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
//            titleBtn.frame = CGRect.init(x: btnX, y: 0, width: btnW, height: btnH)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: UIControlEvents.touchUpInside)
//            self.titleBtns.add(titleBtn)
            titleScrollView.addSubview(titleBtn)
            titleBtn.snp.makeConstraints({ (make) in
                make.left.equalTo(btnX)
                make.top.equalToSuperview()
                make.size.equalTo(CGSize(width: btnW, height: btnH))
            })
            titleBtn.layoutIfNeeded()
            self.titleBtns.add(titleBtn)
            titleScrollView.contentSize = CGSize.init(width: CGFloat(count) * btnW, height: 0)
            titleScrollView.showsHorizontalScrollIndicator = false;
            contentScrollView.contentSize = CGSize.init(width: CGFloat(count) * kScreenWidth, height: 0)
            contentScrollView.showsHorizontalScrollIndicator = false;
            if i == selectedSegmentIndex {
                titleBtnClick(titleBtn: titleBtn)
            }
        }
    }
}
//MARK:-  处理关联事件
extension SegmentViewController{
    @objc func titleBtnClick(titleBtn: UIButton) {
        selButton(btn: titleBtn)
        print(titleBtn.tag)
       
        setupOneViewController(btnTag :titleBtn.tag)
        setupTitleCenter(btn: titleBtn)
        let x :CGFloat  = CGFloat(titleBtn.tag) * kScreenWidth;
        self.contentScrollView.contentOffset = CGPoint.init(x: x, y: 0);
        radioBtn = titleBtn
        
        bottomLine.snp.remakeConstraints { (make) in
//            make.left.equalTo(CGFloat(titleBtn.tag) * 100)
            make.centerX.equalTo(titleBtn.snp.centerX)
            make.top.equalTo(titleScrollView.bounds.size.height-2)
            make.height.equalTo(2)
            make.width.equalTo(titleWidth-10)
        }

    }
    func selButton(btn: UIButton){
        radioBtn.transform = CGAffineTransform(scaleX: 1, y: 1);
        radioBtn.setTitleColor(offSelectColor, for: UIControlState.normal)
        btn.setTitleColor(onSelectColor, for: UIControlState.normal)
        btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
    }
    func setupOneViewController(btnTag: NSInteger){
        let VC : UIViewController = self.childViewControllers[btnTag]
        if (VC.view.superview != nil) {
            return
        }
        let x : CGFloat = CGFloat(btnTag) * kScreenWidth
//        VC.view.frame = CGRect.init(x: x, y: 0, width: kScreenWidth, height: contentScrollView.bounds.size.height)
        self.contentScrollView.addSubview(VC.view)
        VC.view.snp.makeConstraints { (make) in
            make.left.equalTo(x)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: contentScrollView.bounds.size.height))
        }
        
    }
    func setupTitleCenter(btn: UIButton){
        var offsetPoint : CGPoint = titleScrollView.contentOffset
//        offsetPoint.x =  btn.center.x -  kScreenWidth / 2
        offsetPoint.x =  titleWidth * (CGFloat(btn.tag) + 0.5) -  kScreenWidth / 2
        //左边超出处理
        if offsetPoint.x < 0{
            offsetPoint.x = 0
        }
        let maxX : CGFloat = titleScrollView.contentSize.width - kScreenWidth;
        //右边超出处理
        if offsetPoint.x > maxX {
            offsetPoint.x = maxX
        }
        titleScrollView.setContentOffset(offsetPoint, animated: true)
         radioBtn = btn;
    }
}
//MARK:-  处理UIScrollViewDelegate事件
extension SegmentViewController{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
        print(contentOffsetX)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取标题
        let leftI :NSInteger   = NSInteger(scrollView.contentOffset.x / kScreenWidth);
        let rightI :NSInteger   = leftI + 1
        //选中标题
        if (rightI <= titleBtns.count) {
            let titleBtn :UIButton  = titleBtns[leftI] as! UIButton
//            setupOneViewController(btnTag: rightI)
            setupOneViewController(btnTag: leftI)
            selButton(btn: titleBtn)
            setupTitleCenter(btn: titleBtn)
            
            bottomLine.snp.remakeConstraints { (make) in
                make.centerX.equalTo(titleBtn.snp.centerX)
                make.top.equalTo(titleScrollView.bounds.size.height-2)
                make.height.equalTo(2)
                make.width.equalTo(titleWidth-10)
            }
        }
        
        //字体缩放 1.缩放比例 2.缩放那两个按钮
        //获取左边的按钮
        let leftBtn :UIButton = self.titleBtns[leftI] as! UIButton
        //获取右边的按钮
        var rightBtn :UIButton = UIButton()
        if (rightI<self.titleBtns.count) {
            rightBtn = self.titleBtns[rightI] as! UIButton
        }
        var scaleR :CGFloat = scrollView.contentOffset.x / kScreenWidth;
        scaleR -= CGFloat(leftI)
        let scaleL :CGFloat  = 1 - scaleR;
        //缩放按钮
        leftBtn.transform = CGAffineTransform.init(scaleX: scaleL * 0.15 + 1, y: scaleL * 0.15 + 1)
        rightBtn.transform = CGAffineTransform.init(scaleX: scaleR * 0.15 + 1, y: scaleR * 0.15 + 1)
        //颜色渐变
//        let rightColor:UIColor = UIColor.init(red: scaleR, green: 0, blue: 0, alpha: 1)
//        let leftColor:UIColor = UIColor.init(red: scaleL, green: 0, blue: 0, alpha: 1)
//        rightBtn.setTitleColor(rightColor, for: UIControlState.normal)
//        leftBtn.setTitleColor(leftColor, for: UIControlState.normal)
    }
    
}


