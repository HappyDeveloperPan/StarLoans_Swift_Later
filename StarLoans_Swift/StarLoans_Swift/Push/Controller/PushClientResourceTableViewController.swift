//
//  PushClientResourceTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate enum UploadsType {
    case IDCardsFront   //身份证正面
    case IDCardsBack    //身份证反面
    case IDCardsOrBL    //手持身份证或者营业执照
    case OtherProperty  //其他资产
}

class PushClientResourceTableViewController: UITableViewController {
    //MARK: - storyboard连线
    ///抢单价
    @IBOutlet weak var priceTF: UITextField!
    ///有效期限
    @IBOutlet weak var deadlineLB: UILabel!
    ///客户类别
    @IBOutlet weak var clientTypeView: RadioBtnView!
    ///贷款金额
    @IBOutlet weak var loansMoneyTF: UITextField!
    ///贷款周期
    @IBOutlet weak var loansCycleTF: UITextField!
    ///需求天数
    @IBOutlet weak var needDayTF: UITextField!
    ///客户姓名
    @IBOutlet weak var userNameTF: UITextField!
    ///性别
    @IBOutlet weak var sexRadioBtnView: RadioBtnView!
    ///联系电话
    @IBOutlet weak var telephoneTF: UITextField!
    ///职业
    @IBOutlet weak var professionLB: UILabel!
    ///月收入
    @IBOutlet weak var incomeTF: UITextField!
    ///工资发放形式
    @IBOutlet weak var salaryTypeLB: UILabel!
    ///社保情况
    @IBOutlet weak var socialSecurityRadioBtnView: RadioBtnView!
    ///社保购买情况
    @IBOutlet weak var socialSecurityTF: UITextField!
    ///公积金情况
    @IBOutlet weak var providentFundRadioBtnView: RadioBtnView!
    ///公积金购买情况
    @IBOutlet weak var providentFundTF: UITextField!
    ///房产类型
    @IBOutlet weak var houseTypeLB: UILabel!
    ///房产估值
    @IBOutlet weak var houseValuationTF: UITextField!
    ///车产类型
    @IBOutlet weak var carTypeLB: UILabel!
    ///车产估值
    @IBOutlet weak var carValuationTF: UITextField!
    ///信用情况
    @IBOutlet weak var creditTF: UILabel!
    ///其他资产
    @IBOutlet weak var otherPropertyTF: UITextField!
    ///上传身份证正面
    @IBOutlet weak var IDCardsFrontBtn: UIButton!
    ///上传身份证反面
    @IBOutlet weak var IDCardsBackBtn: UIButton!
    ///上传房产证明
    @IBOutlet weak var houseCertiBtn: UIButton!
    ///上传其他资产证明
    @IBOutlet weak var uploadOtherPropertyBtn: UIButton!
    
    //MARK: - 静态数据
    fileprivate let sectionHeaderArr:[String] = ["贷款信息", "个人信息", "资产信息"]
    
    //MARK: - 可操作数据
    fileprivate var uploadsType: UploadsType?
    fileprivate var comboBoxModel = ComboBoxModel() //下拉框数据
    fileprivate var deadlineType: Int = 0       //有效期限
    fileprivate var clientType: Int = 0     //客户类别
    fileprivate var sex: Int = 0        //性别
    fileprivate var professionType: Int = 0     //职业类别
    ///社保类别
    fileprivate var socialSecurityType: Int = 0 {
        didSet {
            if socialSecurityType == 2 {
                socialSecurityBuyHeight = 42
            }else {
                socialSecurityBuyHeight = 0
            }
        }
    }
    ///公积金类别
    fileprivate var providentFundType: Int = 0 {
        didSet {
            if providentFundType == 2 {
                providentFundBuyHeight = 42
            }else {
                providentFundBuyHeight = 0
            }
        }
    }
    ///工资类别
    fileprivate var salaryType: Int = 0
    ///房产类别
    fileprivate var houseType: Int = 0
    ///车产类别
    fileprivate var carType: Int = 0
    ///信用类别
    fileprivate var creditType: Int = 0
    ///社保购买高度
    fileprivate var socialSecurityBuyHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[2, 5]], with: .none)
        }
    }
    ///公积金购买情况
    fileprivate var providentFundBuyHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[2, 7]], with: .none)
        }
    }
    ///房产估值高度
    fileprivate var houseValuationHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[3, 1]], with: .none)
        }
    }
    ///车产估值高度
    fileprivate var carValuationHeight: CGFloat = 0 {
        didSet {
            tableView.reloadRows(at: [[3, 3]], with: .none)
        }
    }
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        getComboBoxData()
    }
    
    func setupBasic() {
        clientTypeView.hSingleSelBtn(titleArray: ["精准客户", "优质客户"], typeE: 1)
        clientTypeView.delegate = self
        sexRadioBtnView.hSingleSelBtn(titleArray: ["男", "女"], typeE: 1)
        sexRadioBtnView.delegate = self
        socialSecurityRadioBtnView.hSingleSelBtn(titleArray: ["无社保", "有社保"], typeE: 1)
        socialSecurityRadioBtnView.delegate = self
        providentFundRadioBtnView.hSingleSelBtn(titleArray: ["无公积金", "有公积金"], typeE: 1)
        providentFundRadioBtnView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 9
        case 3:
            return 7
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = sectionHeaderArr[section-1]
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [2, 5]:
            return socialSecurityBuyHeight
        case [2, 7]:
            return providentFundBuyHeight
        case [3, 1]:
            return houseValuationHeight
        case [3, 3]:
            return carValuationHeight
        default:
            return super .tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    //MARK: - 点击事件
    ///有效期限选择
    @IBAction func deadlineBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.deadlineLB.text = title
            self?.deadlineType = num + 1
        }
        pickerView.nameArr = comboBoxModel.quickbill_valid_period
        kMainWindow??.addSubview(pickerView)
    }
    ///职业选择
    @IBAction func professionBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.professionLB.text = title
            self?.professionType = num + 1
        }
        pickerView.nameArr = comboBoxModel.occupation
        kMainWindow??.addSubview(pickerView)
    }
    ///工资发放形式
    @IBAction func salaryBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.salaryTypeLB.text = title
            self?.salaryType = num + 1
        }
        pickerView.nameArr = comboBoxModel.payment_type
        kMainWindow??.addSubview(pickerView)
    }
    ///房产类型
    @IBAction func houseTypeBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.houseTypeLB.text = title
            self?.houseType = num + 1
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
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.carTypeLB.text = title
            self?.carType = num + 1
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
    @IBAction func creditBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.creditTF.text = title
            self?.creditType = num + 1
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
    ///上传房产证明
    @IBAction func uploadHouseCerti(_ sender: UIButton) {
        uploadsType = UploadsType.IDCardsOrBL
        uploadsPic()
    }
    ///上传其他资产证明
    @IBAction func uploadOtherProperty(_ sender: UIButton) {
        uploadsType = UploadsType.OtherProperty
        uploadsPic()
    }
    
    ///提交资料
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "提交审核", message: "请确认信息准确无误后提交", preferredStyle: .alert)
        let selectOne = UIAlertAction(title: "返回修改", style: .cancel, handler: nil)
        let selectTwo = UIAlertAction(title: "确认", style: .destructive) { [weak self] (action) in
            self?.publishClientData()
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
extension PushClientResourceTableViewController {
    ///发布客户信息
    func publishClientData() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["client_price"] = priceTF.text
        parameters["quickbill_valid_period"] = deadlineType
        parameters["client_type"] = clientType
        parameters["client_loan_need"] = loansMoneyTF.text
        parameters["client_loan_period"] = loansCycleTF.text
        parameters["client_days_need"] = needDayTF.text
        parameters["client_name"] = userNameTF.text
        parameters["client_sex"] = sex
        parameters["client_phone"] = telephoneTF.text
        parameters["client_occupation"] = professionType
        parameters["client_is_social_security"] = socialSecurityType
        parameters["client_social_security_months"] = socialSecurityTF.text
        parameters["client_month_income"] = incomeTF.text
        parameters["client_income_payment_type"] = salaryType
        parameters["client_is_accumulated_funds"] = providentFundType
        parameters["client_accumulated_funds_amounts"] = providentFundTF.text
        parameters["client_house_type"] = houseType
        parameters["client_house_assessment"] = houseValuationTF.text
        parameters["client_car_type"] = carType
        parameters["client_car_assessment"] = carValuationTF.text
        parameters["client_credit_detail"] = creditType
        parameters["client_other_assets"] = otherPropertyTF.text
        parameters["client_idcard_front"] = UIImageJPEGRepresentation((IDCardsFrontBtn.imageView?.image)!, 0.5)
        parameters["client_idcard_back"] = UIImageJPEGRepresentation((IDCardsBackBtn.imageView?.image!)!, 0.5)
        parameters["client_house_certificate"] = UIImageJPEGRepresentation((houseCertiBtn.imageView?.image!)!, 0.5)
        parameters["client_other_assets_front"] = UIImageJPEGRepresentation((uploadOtherPropertyBtn.imageView?.image!)!, 0.5)
        
        JSProgress.showBusy()
        
        NetWorksManager.uploadImages(with: kUrl_PublishClientResources, parameters: parameters, success: { [weak self](jsonData) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                let vc = PushCompleteViewController.loadStoryboard()
                self?.navigationController?.pushViewController(vc, animated: true)
            }else {
                if let msg = jsonData?["msg_zhcn"].stringValue {
                    JSProgress.showFailStatus(with: msg)
                }
            }
            
        }) { (error) in
            JSProgress.hidden()
            JSProgress.showFailStatus(with: "请求失败")
        }
    }
    ///获取下拉框数据
    func getComboBoxData() {
        var parameters = [String: Any]()
        parameters["fields"] = "occupation,payment_type,house_type,car_type,credit,quickbill_valid_period"
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

//MARK: - 系统相册代理方法
extension PushClientResourceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
//        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        switch uploadsType {
        case .IDCardsFront?:
            IDCardsFrontBtn.setImage(image, for: .normal)
        case .IDCardsBack?:
            IDCardsBackBtn.setImage(image, for: .normal)
        case .IDCardsOrBL?:
            houseCertiBtn.setImage(image, for: .normal)
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

//MARK: - 单项选择框代理
extension PushClientResourceTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        if radioBtnView == clientTypeView {
            clientType = index + 1
        }
        if radioBtnView == sexRadioBtnView {
            sex = index + 1
        }
        if radioBtnView == socialSecurityRadioBtnView{
            socialSecurityType = index + 1
        }
        if radioBtnView == providentFundRadioBtnView {
            providentFundType = index + 1
        }
    }
}
