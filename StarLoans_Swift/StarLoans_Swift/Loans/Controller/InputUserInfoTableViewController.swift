//
//  InputUserInfoTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate enum UploadsType {
    case IDCardsFront   //身份证正面
    case IDCardsBack    //身份证反面
    case IDCardsOrBL    //手持身份证或者营业执照
    case OtherProperty  //其他资产
}

class InputUserInfoTableViewController: UITableViewController {
    //MARK: - Storyboard连线
    @IBOutlet weak var flowTwoLB: UILabel!
    ///服务费
    @IBOutlet weak var serviceChargeCell: UITableViewCell!
    @IBOutlet weak var ServiceChargeTF: UITextField!
    ///贷款需求
    @IBOutlet weak var LoansNeedTF: UITextField!
    ///企业名称
    @IBOutlet weak var CompanyNameCell: UITableViewCell!
    @IBOutlet weak var CompanyNameTF: UITextField!
    ///企业法人
    @IBOutlet weak var CompanyLegalPersonCell: UITableViewCell!
    @IBOutlet weak var CompanyLegalPersonTF: UITextField!
    ///客户姓名
    @IBOutlet weak var userNameCell: UITableViewCell!
    @IBOutlet weak var userNameTF: UITextField!
    ///性别
    @IBOutlet weak var sexRadioBtnView: RadioBtnView!
    ///联系电话
    @IBOutlet weak var telephoneCell: UITableViewCell!
    @IBOutlet weak var telephoneTF: UITextField!
    ///身份证号
    @IBOutlet weak var IDCardsCell: UITableViewCell!
    @IBOutlet weak var IDCardsTF: UITextField!
    ///职业
    @IBOutlet weak var professionCell: UITableViewCell!
    @IBOutlet weak var professionLB: UILabel!
    ///月收入
    @IBOutlet weak var incomeCell: UITableViewCell!
    @IBOutlet weak var incomeTF: UITextField!
    ///工资发放形式
    @IBOutlet weak var salaryTypeCell: UITableViewCell!
    @IBOutlet weak var salaryTypeLB: UILabel!
    ///员工人数
    @IBOutlet weak var employeeNumCell: UITableViewCell!
    @IBOutlet weak var employeeTF: UITextField!
    ///社保情况
    @IBOutlet weak var socialSecurityCell: UITableViewCell!
    @IBOutlet weak var socialSecurityRadioBtnView: RadioBtnView!
    ///社保购买情况
    @IBOutlet weak var socialSecurityBuyTF: UITextField!
    ///公积金情况
    @IBOutlet weak var providentFundCell: UITableViewCell!
    @IBOutlet weak var providentFundRadioBtnView: RadioBtnView!
    ///公积金购买情况
    @IBOutlet weak var providentFundBuyTF: UITextField!
    ///房产类型
    @IBOutlet weak var houseTypeLB: UILabel!
    ///房产估值
    @IBOutlet weak var houseValuationTF: UITextField!
    ///车产类型
    @IBOutlet weak var carTypeLB: UILabel!
    ///车产估值
    @IBOutlet weak var carValuationTF: UITextField!
    ///信用情况
    @IBOutlet weak var creditTypeLB: UILabel!
    ///其他资产
    @IBOutlet weak var otherPropertyCell: UITableViewCell!
    @IBOutlet weak var otherPropertyTF: UITextField!
    ///近一年总收入
    @IBOutlet weak var totalIncomeTF: UITextField!
    ///近一年总支出
    @IBOutlet weak var totalExpenditureTF: UITextField!
    ///上传身份证正面
    @IBOutlet weak var IDCardsFrontBtn: UIButton!
    ///上传身份证反面
    @IBOutlet weak var IDCardsBackBtn: UIButton!
    ///上传手持身份证或者营业执照
    @IBOutlet weak var uploadIDCardsOrBLBtn: UIButton!
    @IBOutlet weak var uploadIDCardsOrBLLB: UILabel!
    ///上传其他资产证明
    @IBOutlet weak var uploadOtherPropertyBtn: UIButton!
    ///上传资金用途图片
    @IBOutlet weak var uploadPurposeBtn: UIButton!
    
    //MARK: - 外部属性
    var productId: Int = 0
    var loansProductType: LoansProductType = .selfSupport //产品类别
    var loanClientType: LoanClientType = .personage //用户类别
    
    //MARK: - 内部属性
    fileprivate let sectionHeaderArr:[String] = ["基本信息", "资产信息"]
    fileprivate var uploadsType: UploadsType?   //上传类型
    fileprivate var comboBoxModel = ComboBoxModel() //下拉框数据
    fileprivate var sex: Int = 0    //性别
    fileprivate var providentFund: Int = 0 {    //社保
        didSet {
            if providentFund == 1 {
                providentFundBuyHeight = 42
            }else {
                providentFundBuyHeight = 0
            }
        }
    }
    fileprivate var socialSecurity: Int = 0 {   //公积金
        didSet {
            if socialSecurity == 1 {
                socialSecurityBuyHeight = 42
            }else {
                socialSecurityBuyHeight = 0
            }
        }
    }
    ///社保购买cell高度
    fileprivate var socialSecurityBuyHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[1, 4]], with: .none)
        }
    }
    ///公积金购买cell高度
    fileprivate var providentFundBuyHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[1, 6]], with: .none)
        }
    }
    ///房产估值cell高度
    fileprivate var houseValuationHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[1, 8]], with: .none)
        }
    }
    ///车产估值cell高度
    fileprivate var carValuationHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[1, 10]], with: .none)
        }
    }
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        getComboBoxData()
    }
    
    func setupBasic() {
        if loanClientType == .company {
            flowTwoLB.text = "录入企业信息"
        }else {
            flowTwoLB.text = "录入客户信息"
        }
        socialSecurityRadioBtnView.hSingleSelBtn(titleArray: ["有社保", "无社保"], typeE: 1)
        socialSecurityRadioBtnView.delegate = self
        providentFundRadioBtnView.hSingleSelBtn(titleArray: ["有公积金", "无公积金"], typeE: 1)
        providentFundRadioBtnView.delegate = self
        sexRadioBtnView.hSingleSelBtn(titleArray: ["男","女"], typeE: 1)
        sexRadioBtnView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - TableView代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        }else {
            return 13
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1, 4]:
            return socialSecurityBuyHeight
        case [1, 6]:
            return providentFundBuyHeight
        case [1, 8]:
            return houseValuationHeight
        case [1, 10]:
            return carValuationHeight
        default:
            return super .tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = sectionHeaderArr[section]
        return view
    }
    
    //MARK: - 控件点击事件
    ///职业选择
    @IBAction func professionBtnClick(_ sender: UIButton) {
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.professionLB.text = title
        }
        pickerView.nameArr = comboBoxModel.occupation
        kMainWindow??.addSubview(pickerView)
    }
    ///工资发放形式
    @IBAction func salaryBtnClick(_ sender: UIButton) {
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.salaryTypeLB.text = title
        }
        pickerView.nameArr = comboBoxModel.payment_type
        kMainWindow??.addSubview(pickerView)
    }
    ///房产类型
    @IBAction func houseTypeBtnClick(_ sender: UIButton) {
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.houseTypeLB.text = title
            if num != 0 {
                self?.houseValuationHeight = 42
            }else {
                self?.houseValuationHeight = 0
            }
        }
        pickerView.nameArr = comboBoxModel.house_type
        kMainWindow??.addSubview(pickerView)
    }
    ///车产类型
    @IBAction func carTypeBtnClick(_ sender: UIButton) {
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.carTypeLB.text = title
            if num != 0 {
                self?.carValuationHeight = 42
            }else {
                self?.carValuationHeight = 0
            }
        }
        pickerView.nameArr = comboBoxModel.car_type
        kMainWindow??.addSubview(pickerView)
    }
    ///信用情况
    @IBAction func CreditTypeBtnClick(_ sender: UIButton) {
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.creditTypeLB.text = title
        }
        pickerView.nameArr = comboBoxModel.credit
        kMainWindow??.addSubview(pickerView)
    }
    ///上传身份证正面
    @IBAction func uploadIDCardsFront(_ sender: UIButton) {
        uploadsType = UploadsType.IDCardsFront
        uploadsPic()
    }
    ///上传身份证反面
    @IBAction func uploadIDCardsBack(_ sender: UIButton) {
        uploadsType = UploadsType.IDCardsBack
        uploadsPic()
    }
    ///上传手持身份证或者营业执照
    @IBAction func uploadIDCardsOrBL(_ sender: UIButton) {
        uploadsType = UploadsType.IDCardsOrBL
        uploadsPic()
    }
    ///上传其他资产证明
    @IBAction func uploadOtherProperty(_ sender: UIButton) {
        uploadsType = UploadsType.OtherProperty
        uploadsPic()
    }
    
    ///上传资金用途文件
    @IBAction func uploadPurposeBtnClick(_ sender: UIButton) {
        
    }
    ///提交资料
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "提交审核", message: "请确认信息准确无误后提交", preferredStyle: .alert)
        let selectOne = UIAlertAction(title: "返回修改", style: .cancel, handler: nil)
        let selectTwo = UIAlertAction(title: "确认", style: .destructive) { [weak self] (action) in
            let vc = CommitCompleteViewController.loadStoryboard()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(selectOne)
        alertController.addAction(selectTwo)
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadsPic() {
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
}

//MARK: - 数据处理
extension InputUserInfoTableViewController {
    ///获取下拉框数据
    func getComboBoxData() {
        var parameters = [String: Any]()
        parameters["fields"] = "occupation,payment_type,house_type,car_type,credit,loan_type"
        NetWorksManager.requst(with: kUrl_ComboBox, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"] {
                    self?.comboBoxModel = ComboBoxModel(with: data)
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

//MARK: - 系统相册代理
extension InputUserInfoTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        switch uploadsType {
        case .IDCardsFront?:
            IDCardsFrontBtn.setImage(image, for: .normal)
        case .IDCardsBack?:
            IDCardsBackBtn.setImage(image, for: .normal)
        case .IDCardsOrBL?:
            uploadIDCardsOrBLBtn.setImage(image, for: .normal)
        case .OtherProperty?:
            uploadOtherPropertyBtn.setImage(image, for: .normal)
        default:
            break
        }
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

//MARK: - 单选框按钮
extension InputUserInfoTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        if radioBtnView == sexRadioBtnView {
            sex = index + 1
        }
        if radioBtnView == socialSecurityRadioBtnView{
            socialSecurity = index + 1
        }
        if radioBtnView == providentFundRadioBtnView {
            providentFund = index + 1
        }
    }

}

//MARK: - TableViewSection头视图
class SectionHeaderView: UIView {
    lazy var topBackView: UIView = { [unowned self] in
        let topBackView = UIView()
        self.addSubview(topBackView)
        topBackView.backgroundColor = kHomeBackColor
        return topBackView
    }()
    
    lazy var verLine: UIView = { [unowned self] in
        let verLine = UIView()
        self.addSubview(verLine)
        verLine.backgroundColor = kMainColor
        return verLine
    }()
    
    lazy var titleLB: UILabel = { [unowned self] in
        let titleLB = UILabel()
        self.addSubview(titleLB)
        titleLB.textColor = kTitleColor
        titleLB.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return titleLB
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        topBackView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        
        verLine.snp.makeConstraints { (make) in
            make.top.equalTo(topBackView.snp.bottom).offset(10)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 2, height: 15))
        }
        
        titleLB.snp.makeConstraints { (make) in
            make.top.equalTo(topBackView.snp.bottom).offset(11)
            make.left.equalTo(verLine.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 80, height: 14))
        }
    }
}
