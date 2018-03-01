//
//  LoansDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/26.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class LoansDetailViewController: BaseViewController, StoryboardLoadable {
    //MARK: - storyboard连线
    @IBOutlet weak var mainView: UIView!
    ///产品介绍
    @IBOutlet weak var productView: LoansProductView!
    ///产品优势
    @IBOutlet weak var advantageView: UIView!
    @IBOutlet weak var advenContentLB: UILabel!
    @IBOutlet weak var advenContentTransView: UIView!
    @IBOutlet weak var lookMoreBtn: UIButton!
    ///利率详情
    @IBOutlet weak var deadlineLB: UILabel!
    @IBOutlet weak var interestRateView: UIView!
    @IBOutlet weak var interestRateViewHeight: NSLayoutConstraint!
    @IBOutlet weak var interestRateViewTop: NSLayoutConstraint!
    ///费用计算
    @IBOutlet weak var costCountView: UIView!
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var costCountLB: UILabel!
    @IBOutlet weak var costCountVIewTop: NSLayoutConstraint!
    ///办理流程
    @IBOutlet weak var flowView: UIView!
    @IBOutlet weak var flowImg1: UIImageView!
    @IBOutlet weak var flowJiantou1: UIImageView!
    @IBOutlet weak var flowLB1: UILabel!
    @IBOutlet weak var flowLB2: UILabel!
    ///申请条件
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var conditionContentLB: UILabel!
    ///所需材料
    @IBOutlet weak var materialsView: UIView!
    @IBOutlet weak var materialsContentLB: UILabel!
    ///问题讨论
    @IBOutlet weak var moreProblemBtn: UIButton!
    @IBOutlet weak var problemView: UIView!
    @IBOutlet weak var problemTableView: UITableView!
    @IBOutlet weak var problemTableViewHeight: NSLayoutConstraint!
    
    //MARK: - 可操作数据
    ///产品类型
    var loansProductType: LoansProductType = .selfSupport
    var productModel: ProductModel = ProductModel()
    fileprivate var cellHeightArr: [CGFloat] = [CGFloat]()
    //MARK: - 懒加载
    ///利率图标
    lazy var gridView: GridView = { [unowned self] in
        let gridView =  GridView(frame: .zero, collectionViewLayout: UICollectionGridViewLayout())
        gridView.setColumns(columns: ["抵押比例", "7成", "8成", "9成", "10成"])
        gridView.addRow(row: ["年化利率", "8%", "9%", "10%", "11%"])
        self.interestRateView.addSubview(gridView)
        return gridView
    }()
    
    lazy var formatter: DateFormatter = { [unowned self] in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
        }()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseConfig()
        setupBaseData()
//        getLoansDetailData()
    }
    
    ///控件基本配置
    func setupBaseConfig() {
        //产品介绍
        productView.loansNum.adjustsFontSizeToFitWidth = true
        //产品优势
        advenContentLB.sizeToFit()
        advenContentLB.numberOfLines = 5
        //费用计算
        moneyTF.keyboardType = .numberPad
        moneyTF.addTarget(self, action: #selector(costCount(_:)), for: .editingChanged)
        costCountLB.adjustsFontSizeToFitWidth = true
        //办理流程
        flowLB2.adjustsFontSizeToFitWidth = true
        //申请条件
        conditionContentLB.sizeToFit()
        conditionContentLB.numberOfLines = 0
        //所需材料
        materialsContentLB.sizeToFit()
        materialsContentLB.numberOfLines = 0
        //问题讨论
        problemTableView.pan_registerCell(cell: ProblemCell.self)
        problemTableView.isScrollEnabled = false
        problemTableView.delegate = self
        problemTableView.dataSource = self
        problemTableView.estimatedRowHeight = 160
        problemTableView.rowHeight = UITableViewAutomaticDimension
        problemTableViewHeight.constant = CGFloat(productModel.product_question.count * 160)
        
        if loansProductType == .thirdSupport  {
            productView.rtTitle2.isHidden = true
            interestRateView.isHidden = true
            interestRateViewHeight.constant = 0
            interestRateViewTop.constant = 0
            flowLB1.isHidden = true
            flowImg1.isHidden = true
            flowJiantou1.isHidden = true
        }
    }
    
    ///基本数据配置
    func setupBaseData() {
        title = productModel.product
        productView.logoImg.setImage(with: productModel.logo)
        productView.loansNum.text = String(productModel.quota)
        productView.rtTitle1.text = productModel.label
        productView.lbContentLb.text = String(productModel.return_commission) + "%"
        productView.cbContentLb.text = String(productModel.claim_amount) + "万"
        productView.rbContentLb.text = String(productModel.leader_number) + "人"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
        getLoansDetailData()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
        }
        advenContentTransView.translucence()
        
        gridView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-18)
            make.left.equalTo(48)
            make.right.equalTo(-48)
            make.height.equalTo(71)
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
    

    @IBAction func lookMore(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            
            advenContentTransView.isHidden = true
            advenContentLB.numberOfLines = 0
            
        }else {
            sender.isSelected = false
    
            advenContentTransView.isHidden = false
            advenContentLB.numberOfLines = 5
        }
        
    }
    
    ///费用计算
    @objc func costCount(_ sender: UITextField) {
        guard (sender.text?.isPurnInt())! else {
            costCountLB.text = "费用: "
            return
        }
        let cost = Double(sender.text!)! * 10000 * 0.08
        if cost > 10000 {
            if Int(sender.text!)! > 99999{
                costCountLB.text = "超出可贷款金额"
            }else {
                costCountLB.text = "费用: " + String(cost/10000) + "万"
            }
        }else {
            costCountLB.text = "费用: " + String(cost)
        }
    }
    
    @IBAction func moreProblemClick(_ sender: UIButton) {
        let vc = LoansMoreProblemViewController()
        vc.productId = productModel.product_id
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func taskBtnClick(_ sender: UIButton) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        let vc = AuthorizationViewController.loadStoryboard()
        vc.productId = productModel.product_id
        vc.loansProductType = loansProductType
        vc.url = productModel.url
        if productModel.card == 1 || productModel.card == 3{
            vc.loanClientType = .personage
        }
        if productModel.card == 2 || productModel.card == 4{
            vc.loanClientType = .company
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - 数据处理部分
extension LoansDetailViewController {
    ///请求页面数据
    func getLoansDetailData() {
        
        JSProgress.showBusy()
        
        var parameters = [String: Any]()
        parameters["product_id"] = productModel.product_id
        NetWorksManager.requst(with: kUrl_LoansProductDetail, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    self?.productModel = ProductModel(with: data)
                    self?.updateLoansDetailData()
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
            JSProgress.hidden()
        }
    }
    
    ///刷新页面数据
    func updateLoansDetailData() {
        setupBaseData()
        advenContentLB.text = productModel.desc
        deadlineLB.text = String(productModel.min_term) + "-" + String(productModel.max_term) + "年"
        conditionContentLB.text = productModel.require
        materialsContentLB.text = productModel.info
        problemTableViewHeight.constant = CGFloat(productModel.product_question.count * 2000)
        cellHeightArr.removeAll()
        problemTableView.reloadData()
    }
}

//MARK: - UITableView代理
extension LoansDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModel.product_question.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.pan_dequeueReusableCell(indexPath: indexPath) as ProblemCell
        cell.setProblemCellData(QuestionModel(with: productModel.product_question[indexPath.row]), formatter: formatter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightArr.append(cell.height)
        if indexPath.row == productModel.product_question.count - 1 {
            var tableViewHeight: CGFloat = 0
            for height in cellHeightArr {
                tableViewHeight += height
            }
            problemTableViewHeight.constant = tableViewHeight
        }
    }
    
}
