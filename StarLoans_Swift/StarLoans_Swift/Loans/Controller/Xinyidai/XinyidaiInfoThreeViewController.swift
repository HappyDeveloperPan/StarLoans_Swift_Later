//
//  XinyidaiInfoThreeViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class XinyidaiInfoThreeViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: - StoryBoard连线
    /// 切换控件
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    // MARK: - 懒加载
    lazy var segmentview: SMSegmentView = { [unowned self] in
        let appearance = SMSegmentAppearance()
        appearance.segmentOnSelectionColour = UIColor.white
        appearance.segmentOffSelectionColour = UIColor.white
        appearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 15.0)
        appearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 15.0)
        appearance.titleOnSelectionColour = kMainColor
        appearance.titleOffSelectionColour = kTitleColor
        appearance.contentVerticalMargin = 10.0
        appearance.titleGravity = .right
        
        let segmentview = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 1, segmentAppearance: appearance)
        self.segmentView.addSubview(segmentview)
        segmentview.backgroundColor = UIColor.white
        segmentview.addSegmentWithTitle("我是上班族", onSelectionImage: nil, offSelectionImage: nil)
        segmentview.addSegmentWithTitle("我是企业主", onSelectionImage: nil, offSelectionImage: nil)
        segmentview.selectedSegmentIndex = 0
        segmentview.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentview
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "录入客户信息"
        scrollView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        segmentview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.layoutIfNeeded()
        tableViewWidth.constant = kScreenWidth
        tableViewHeight.constant = scrollView.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - 控件点击事件
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let x = kScreenWidth * CGFloat(segmentView.selectedSegmentIndex)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

//MARK: - UIScrollView代理
extension XinyidaiInfoThreeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            segmentview.selectedSegmentIndex = Int(self.scrollView.contentOffset.x / kScreenWidth)
        }
    }
}
