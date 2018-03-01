//
//  IDApproveTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/5.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

enum ApproveType {
    case managerIdentity    //机构经理身份认证
    case managerJob         //机构经理工作认证
    case brokerIdentity     //经纪人身份认证
    case brokerJob          //经纪人工作认证
}

fileprivate enum UploadBtnType {
    case uploadLeft     //左边按钮
    case uploadRight    //右边按钮
}

class IDApproveTableViewController: UITableViewController {
    @IBOutlet weak var IDFlowImg: UIImageView!
    @IBOutlet weak var jobFlowImg: UIImageView!
    @IBOutlet weak var IDFlowLB: UILabel!
    @IBOutlet weak var jobFlowLB: UILabel!
    
    @IBOutlet weak var cellHeadTitle: UILabel!
    
    @IBOutlet weak var cellOneTitleLB: UILabel!
    @IBOutlet weak var cellOneTF: UITextField!
    
    @IBOutlet weak var sexCell: UITableViewCell!
    @IBOutlet weak var sexView: RadioBtnView!
    
    @IBOutlet weak var cellTwo: UITableViewCell!
    @IBOutlet weak var cellTwoTitleLB: UILabel!
    @IBOutlet weak var cellTwoTF: UITextField!
    @IBOutlet weak var cellTwoContentLB: UILabel!
    
    @IBOutlet weak var cellThreeTitleLB: UILabel!
    @IBOutlet weak var cellThreeTF: UITextField!
    
    @IBOutlet weak var uploadLeftBtn: UIButton!
    @IBOutlet weak var uploadLeftLB: UILabel!
    @IBOutlet weak var uploadRightBtn: UIButton!
    @IBOutlet weak var uploadRightLB: UILabel!
    @IBOutlet weak var commitBtn: UIButton!
    
    //MARK: - 可操作数据
    var approveType: ApproveType = .managerIdentity
    fileprivate var uploadBtnType: UploadBtnType?
    var approveModel: ApproveModel = ApproveModel()
    var cardFront: UIImageView = UIImageView()
    var cardBackend: UIImageView = UIImageView()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
    }
    
    func setupBasic() {
        switch approveType {
        case .brokerJob:
            IDFlowImg.image = #imageLiteral(resourceName: "ICON-shouquanchenggong")
            jobFlowImg.image = #imageLiteral(resourceName: "ICON-shouquanqueren")
            IDFlowLB.font = UIFont.systemFont(ofSize: 14)
            jobFlowLB.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            cellHeadTitle.text = "机构信息"
            cellOneTitleLB.text = "公司名称"
            cellOneTF.placeholder = "请输入公司名称"
            cellTwo.accessoryType = .disclosureIndicator
            cellTwoTitleLB.text = "公司类型"
            cellTwoTF.isHidden = true
            cellTwoContentLB.isHidden = false
            cellTwoContentLB.text = "请选择公司类型"
            cellThreeTitleLB.text = "详细地址"
            cellThreeTF.placeholder = "区县街道门牌信息"
            uploadLeftLB.text = "请上传公司LOGO"
            uploadRightLB.text = "请上传工牌和名片"
            commitBtn.setTitle("确认提交", for: .normal)
        case .managerJob:
            IDFlowImg.image = #imageLiteral(resourceName: "ICON-shouquanchenggong")
            jobFlowImg.image = #imageLiteral(resourceName: "ICON-shouquanqueren")
            IDFlowLB.font = UIFont.systemFont(ofSize: 14)
            jobFlowLB.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            cellHeadTitle.text = "机构信息"
            cellOneTitleLB.text = "机构名称"
            cellOneTF.placeholder = "请输入机构名称"
            cellTwoTitleLB.text = "详细地址"
            cellTwoTF.placeholder = "区县街道门牌信息'"
            cellThreeTitleLB.text = "所属营业厅"
            cellThreeTF.placeholder = "请输入营业厅名称"
            uploadLeftLB.text = "请上传公司LOGO"
            uploadRightLB.text = "请上传工牌和名片"
            commitBtn.setTitle("确认提交", for: .normal)
        case .managerIdentity, .brokerIdentity:
            sexView.hSingleSelBtn(titleArray: ["男", "女"], typeE: 1)
            sexView.delegate = self
        }
        commitBtn.layer.cornerRadius = commitBtn.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && (approveType == .brokerJob || approveType == .managerJob){
            return 0
        }
        return super .tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //选择公司类型
        if indexPath.row == 2 && approveType == .brokerJob {
            let pickerView = PickerView()
            pickerView.changeTitleAndClosure = { [weak self] (title:String , num : Int)  in
                self?.cellTwoContentLB.text = title
            }
            pickerView.nameArr = ["股份制企业","民营企业","个体经营"]
            kMainWindow??.addSubview(pickerView)
        }
    }
    
    @IBAction func uploadLeftBtnClick(_ sender: UIButton) {
        uploadBtnType = UploadBtnType.uploadLeft
        uploadsPic()
    }
    @IBAction func uploadRightBtnClick(_ sender: UIButton) {
        uploadBtnType = UploadBtnType.uploadRight
        uploadsPic()
    }
    ///根据页面类型确定提交点击事件
    @IBAction func commitBtnClick(_ sender: UIButton) {
        switch approveType {
        case .brokerIdentity:
            let vc = IDApproveViewController.loadStoryboard()
            vc.approveType = .brokerJob
            vc.approveModel.type = 1
            vc.approveModel.name = cellOneTF.text!
            vc.approveModel.sex = approveModel.sex
            vc.approveModel.phone = cellTwoTF.text!
            vc.approveModel.cardid = cellThreeTF.text!
            vc.cardFront.image = uploadLeftBtn.imageView?.image
            vc.cardBackend.image = uploadRightBtn.imageView?.image
            navigationController?.pushViewController(vc, animated: true)
        case .managerIdentity:
            let vc = IDApproveViewController.loadStoryboard()
            vc.approveType = .managerJob
            vc.approveModel.type = 2
            vc.approveModel.name = cellOneTF.text!
            vc.approveModel.sex = approveModel.sex
            vc.approveModel.phone = cellTwoTF.text!
            vc.approveModel.cardid = cellThreeTF.text!
            vc.cardFront.image = uploadLeftBtn.imageView?.image
            vc.cardBackend.image = uploadRightBtn.imageView?.image
            navigationController?.pushViewController(vc, animated: true)
        case .brokerJob:
            commitApproveData()
        case .managerJob:
            commitApproveData()
        }
    }
    
    ///上传图片
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

extension IDApproveTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
//        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        switch uploadBtnType {
        case .uploadLeft?:
            uploadLeftBtn.setImage(image, for: .normal)
            if approveType == .brokerIdentity || approveType == .managerIdentity {
                cardFront.image = image
            }
        case .uploadRight?:
            uploadRightBtn.setImage(image, for: .normal)
            if approveType == .brokerIdentity || approveType == .managerIdentity {
                cardBackend.image = image
            }
        default: break
        }
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

extension IDApproveTableViewController {
    func commitApproveData() {
        let alertController = UIAlertController(title: "提交审核", message: "请确认信息准确无误后提交", preferredStyle: .alert)
        let selectOne = UIAlertAction(title: "返回修改", style: .cancel, handler: nil)
        let selectTwo = UIAlertAction(title: "确认", style: .destructive) { [weak self] (action) in
            self?.postDataToServicer()
        }
        alertController.addAction(selectOne)
        alertController.addAction(selectTwo)
        present(alertController, animated: true, completion: nil)
    }
    
    func postDataToServicer() {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["type"] = approveModel.type
        parameters["name"] = approveModel.name
        parameters["sex"] = approveModel.sex
        parameters["phone"] = approveModel.phone
        parameters["cardid"] = approveModel.cardid
        parameters["card_front"] = UIImageJPEGRepresentation(cardFront.image!, 0.5)
        parameters["card_backend"] = UIImageJPEGRepresentation(cardBackend.image!, 0.5)
//        if let image = cardFront.image {
//            parameters["card_front"] = UIImageJPEGRepresentation(image, 0.5)
////            parameters["card_backend"] = UIImageJPEGRepresentation(cardBackend.image!, 0.5)
//        }
//        if let image = cardBackend.image {
////            parameters["card_front"] = UIImageJPEGRepresentation(cardFront.image!, 0.5)
//            parameters["card_backend"] = UIImageJPEGRepresentation(image, 0.5)
//        }
        parameters["company_name"] = cellOneTF.text
        parameters["company_type"] = cellTwoContentLB.text
        parameters["company_office"] = cellThreeTF.text
        parameters["company_address"] = cellThreeTF.text
        parameters["company_logo"] = UIImageJPEGRepresentation((uploadLeftBtn.imageView?.image)!, 0.5)
        parameters["workcard_businesscard"] = UIImageJPEGRepresentation((uploadRightBtn.imageView?.image)!, 0.5)
        
        JSProgress.showBusy()
        
        NetWorksManager.uploadImages(with: kUrl_AddApprove, parameters: parameters, success: { [weak self] (jsonData) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                UserManager.shareManager.userModel.is_audit = 2
                let vc = ApproveCommitedViewController.loadStoryboard()
                self?.navigationController?.pushViewController(vc, animated: true)
//                JSProgress.showSucessStatus(with: "提交成功")
            }else {
                if let msg = jsonData?["msg_zhcn"].stringValue {
                    JSProgress.showFailStatus(with: msg)
                }
            }
        }) { (error) in
            JSProgress.showFailStatus(with: "请求失败")
        }
    }
}

extension IDApproveTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        approveModel.sex = index + 1
    }
}
