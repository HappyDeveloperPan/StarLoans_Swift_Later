//
//  QuickBillDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class QuickBillDetailViewController: BaseViewController, StoryboardLoadable{
    //MARK: - Storyboard连线
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constrainstsHeight: NSLayoutConstraint!
    @IBOutlet weak var constrainstsWidth: NSLayoutConstraint!
    ///贷款需求
    @IBOutlet weak var loanNeedLB: UILabel!
    ///贷款周期
    @IBOutlet weak var loanCycleLB: UILabel!
    ///需求程度
    @IBOutlet weak var needDayLB: UILabel!
    ///切换控件
    @IBOutlet weak var segmentView: UIView!
    ///抢单支付按钮
    @IBOutlet weak var commitBtn: UIButton!
    
    //MARK: - 外部属性
    var clientModel = ClientInfoModel()
    //MARK: - 内部属性
//    fileprivate var clientModel = ClientInfoModel()
    fileprivate var QBDUserInfoVC = QBDUserInfoTableViewController()
    fileprivate var QBDPropertyVC = QBDPropertyTableViewController()
    //MARK: - 懒加载
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
        
        let segmentview = SMSegmentView(frame: .zero, dividerColour: UIColor.RGB(with: 210, green: 210, blue: 210), dividerWidth: 0, segmentAppearance: appearance)
        self.segmentView.addSubview(segmentview)
        segmentview.backgroundColor = UIColor.white
        segmentview.addSegmentWithTitle("个人信息", onSelectionImage: nil, offSelectionImage: nil)
        segmentview.addSegmentWithTitle("资产信息", onSelectionImage: nil, offSelectionImage: nil)
        segmentview.selectedSegmentIndex = 0
        segmentview.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        return segmentview
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        setBasicData()
        getQuickBillDetailData()
    }
    
    func setupBasic() {
        view.backgroundColor = kHomeBackColor
        loanNeedLB.adjustsFontSizeToFitWidth = true
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }
    
    func setBasicData() {
        if clientModel.client_loan_need >= 10000 {
            loanNeedLB.text = String(clientModel.client_loan_need/10000) + "万"
        }else {
            loanNeedLB.text = String(clientModel.client_loan_need) + "元"
        }
        loanCycleLB.text = String(clientModel.client_loan_period) + "个月"
        needDayLB.text = String(clientModel.client_days_need) + "天内"
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        segmentview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        constrainstsWidth.constant = kScreenWidth
        constrainstsHeight.constant = scrollView.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: QBDUserInfoTableViewController.classForCoder()) {
            QBDUserInfoVC = segue.destination as! QBDUserInfoTableViewController
//            vc1.clientModel = clientModel
        }
        if segue.destination.isKind(of: QBDPropertyTableViewController.classForCoder()) {
            QBDPropertyVC = segue.destination as! QBDPropertyTableViewController
//            vc2.clientModel = clientModel
        }
    }
    
    //MARK: - 控件点击事件
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        let x = kScreenWidth * CGFloat(segmentView.selectedSegmentIndex)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    //抢单按钮点击
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let vc = PayViewController.loadStoryboard()
        vc.price = Float(clientModel.client_price)
        vc.goodsId = clientModel.client_id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - 数据处理部分
extension QuickBillDetailViewController {
    func getQuickBillDetailData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["client_id"] = clientModel.client_id
        NetWorksManager.requst(with: kUrl_QuickBillDetail, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    self?.clientModel = ClientInfoModel(with: data)
                    self?.QBDUserInfoVC.setBasicData((self?.clientModel)!)
                    self?.QBDPropertyVC.setBasicData((self?.clientModel)!)
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

//MARK: - UIScrollView代理
extension QuickBillDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            segmentview.selectedSegmentIndex = Int(self.scrollView.contentOffset.x / kScreenWidth)
        }
    }
}
