//
//  PushProductResourceTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class PushProductResourceTableViewController: UITableViewController {
    //MARK: - storyboard连线
    //公司LOGO
    @IBOutlet weak var logoLB: UILabel!
    @IBOutlet weak var logoBtn: UIButton!
    //公司名称
    @IBOutlet weak var CompanyNameTF: UITextField!
    //产品名称
    @IBOutlet weak var productNameTF: UITextField!
    //贷款范围
    @IBOutlet weak var loansRange1TF: UITextField!
    @IBOutlet weak var loansRange2TF: UITextField!
    //贷款类别
    @IBOutlet weak var loansTypeLB: UILabel!
    //返佣比例
    @IBOutlet weak var returnMoneyTF: UITextField!
    //月利率
    @IBOutlet weak var monthInterestRateTF: UITextField!
    //贷款期限
    @IBOutlet weak var loanDeadlineTF: UITextField!
    //产品优势
    @IBOutlet weak var productAdvenTV: MyTextView!
    //办理流程
    @IBOutlet weak var flow1TF: UITextField!
    @IBOutlet weak var flow2TF: UITextField!
    @IBOutlet weak var flow3TF: UITextField!
    @IBOutlet weak var flow4TF: UITextField!
    //申请条件
    @IBOutlet weak var conditionTV: MyTextView!
    //所需材料
    @IBOutlet weak var needMaterialsTV: MyTextView!
    
    //MARK: - 静态数据
    fileprivate let sectionHeaderArr:[String] = ["基本信息", "产品优势", "办理流程", "申请条件", "所需材料"]
    
    //MARK: - 可操作数据
    fileprivate var loansType: Int = 0
    fileprivate var comboBoxModel = ComboBoxModel() ///下拉框数据
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        getComboBoxData()
    }
    
    func setupBasic() {
        productAdvenTV.placeholder = "请言简意赅的介绍您的产品优势，好的产品介绍会提高成单率。"
        productAdvenTV.layer.borderWidth = 0.5
        productAdvenTV.layer.cornerRadius = 5
        productAdvenTV.layer.borderColor = UIColor.RGB(with: 198, green: 198, blue: 198).cgColor
        
        conditionTV.placeholder = "请简要描述申请条件"
        conditionTV.layer.borderWidth = 0.5
        conditionTV.layer.cornerRadius = 5
        conditionTV.layer.borderColor = UIColor.RGB(with: 198, green: 198, blue: 198).cgColor
        
        needMaterialsTV.placeholder = "请简要描述所需材料"
        needMaterialsTV.layer.borderWidth = 0.5
        needMaterialsTV.layer.cornerRadius = 5
        needMaterialsTV.layer.borderColor = UIColor.RGB(with: 198, green: 198, blue: 198).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = sectionHeaderArr[section]
        return view
    }
    
    //MARK: - 点击事件
    ///上传公司logo
    @IBAction func uploadOtherProperty(_ sender: UIButton) {
        uploadsPic()
    }
    
    ///选择贷款类别
    @IBAction func loansTypeBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let pickerView = PickerView()
        pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
            self?.loansTypeLB.text = title
            self?.loansType = num + 1
        }
        pickerView.nameArr = comboBoxModel.loan_type
        kMainWindow??.addSubview(pickerView)
    }
    
    ///提交信息
    @IBAction func commitBtnClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "提交审核", message: "请确认信息准确无误后提交", preferredStyle: .alert)
        let selectOne = UIAlertAction(title: "返回修改", style: .cancel, handler: nil)
        let selectTwo = UIAlertAction(title: "确认", style: .destructive) { [weak self] (action) in
            self?.uploadProduct()
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
extension PushProductResourceTableViewController {
    ///发布客户产品
    func uploadProduct() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["company_logo"] = UIImageJPEGRepresentation((logoBtn.imageView?.image)!, 0.5)
        parameters["company_name"] = CompanyNameTF.text
        parameters["product"] = productNameTF.text
        parameters["quota_min"] = loansRange1TF.text
        parameters["quota"] = loansRange2TF.text
        parameters["card"] = loansType
        parameters["return_commission"] = returnMoneyTF.text
        parameters["interest"] = monthInterestRateTF.text
        parameters["desc"] = productAdvenTV.text
        parameters["process_step_one"] = flow1TF.text
        parameters["process_step_two"] = flow2TF.text
        parameters["process_step_three"] = flow3TF.text
        parameters["process_step_four"] = flow4TF.text
        parameters["require"] = conditionTV.text
        parameters["info"] = needMaterialsTV.text
        parameters["min_term"] = loanDeadlineTF.text
        
        JSProgress.showBusy()
        
        NetWorksManager.uploadImages(with: kUrl_PublishProductResources, parameters: parameters, success: { [weak self] (jsonData) in
            
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
        parameters["fields"] = "loan_type"
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

//MARK: - 相册代理
extension PushProductResourceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
//        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        logoBtn.setImage(image, for: .normal)
        logoLB.text = ""
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}
