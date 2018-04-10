//
//  BaoyidaiInfoTwoTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class BaoyidaiInfoTwoTableViewController: UITableViewController {
    // MARK: - Storyboard连线
    @IBOutlet weak var companyNameTF: UITextField!  //公司名称
    @IBOutlet weak var industryLB: UILabel! //行业
    @IBOutlet weak var lawsuitView: RadioBtnView!   //公司有无诉讼
    @IBOutlet weak var lawsuitMaterialBtn: UIButton!    //诉讼材料按钮
    @IBOutlet weak var companyAddressLB: UILabel!   //公司地址
    @IBOutlet weak var addressDetailTF: UITextField!    //公司详细地址
    @IBOutlet weak var registerTimeLB: UILabel! //注册时间
    @IBOutlet weak var flowTF: UITextField! //流水
    @IBOutlet weak var businessTF: UITextField! //公司主营业务
    @IBOutlet weak var turnoverTF: UITextField! //营业额
    @IBOutlet weak var profitYearTF: UITextField!   //年营业额
    
    // MARK: - 外部属性
    var comboBoxModel = ComboBoxModel() //下拉框数据
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasic()
    }
    
    func setUpBasic() {
        lawsuitView.hSingleSelBtn(titleArray: ["有","无"], typeE: 1)
        lawsuitView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    // MARK: - 控件点击事件
    
    /// 所属行业
    ///
    /// - Parameter sender: 按钮
    @IBAction func industryBtnClick(_ sender: UIButton) {
        CGXPickerView.showStringPicker(withTitle: "", dataSource: comboBoxModel.credit, defaultSelValue: nil, isAutoSelect: false, manager: nil) { [weak self] (selectValue, selectRow) in
            self?.industryLB.text = selectValue as? String
        }
    }
    
    /// 诉讼材料上传
    ///
    /// - Parameter sender: 上传按钮
    @IBAction func lawsuitMaterialBtnClick(_ sender: UIButton) {
        uploadsPic()
    }
    
    /// 公司地址
    ///
    /// - Parameter sender: 按钮
    @IBAction func companyAddressBtnClick(_ sender: UIButton) {
        CGXPickerView.showAddressPicker(withTitle: "", defaultSelected: [0,0,0], isAutoSelect: false, manager: nil) { [weak self] (selectAddressArr, selectAddressRow) in
            let arr = selectAddressArr as? Array<String>
            self?.companyAddressLB.text = arr![0] + arr![1] + arr![2]
        }
    }
    
    /// 公司注册时间
    ///
    /// - Parameter sender: 按钮
    @IBAction func registerTimeBtnClick(_ sender: UIButton) {
        let date = Date()
        let format = DateFormatter()
        format.date(from: "yyyy-MM-dd HH:mm:ss")
        let nowStr = format.string(from: date)
        CGXPickerView.showDatePicker(withTitle: "", dateType: .date, defaultSelValue: nil, minDateStr: "1900-01-01 00:00:00", maxDateStr: nowStr, isAutoSelect: false, manager: nil) { [weak self] (selectValue) in
            self?.registerTimeLB.text = selectValue
        }
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = BaoyidaiInfoThreeViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 数据处理
extension BaoyidaiInfoTwoTableViewController {
    /// 图片上传
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

//MARK: - 系统相册代理
extension BaoyidaiInfoTwoTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        lawsuitMaterialBtn.setImage(image, for: .normal)
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

//MARK: - 单选框按钮
extension BaoyidaiInfoTwoTableViewController: RadioBtnViewDelegate {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int) {
        switch radioBtnView {
        case lawsuitView:print("sexView被点击")
        default:break
        }
    }
    
}
