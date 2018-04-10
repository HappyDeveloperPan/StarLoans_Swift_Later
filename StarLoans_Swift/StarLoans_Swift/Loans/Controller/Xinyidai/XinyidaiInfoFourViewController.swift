//
//  XinyidaiInfoFourViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/2.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import IBAnimatable

class XinyidaiInfoFourViewController: BaseViewController, StoryboardLoadable {
    
    enum ImageType: Int {
        case picOne
        case picTwo
        case picThree
        case picFour
        case picFive
        case picSix
    }
    // MARK: - StoryBoard连线
    @IBOutlet weak var picOneBtn: UIButton!
    @IBOutlet weak var picTwoBtn: UIButton!
    @IBOutlet weak var picThreeBtn: UIButton!
    @IBOutlet weak var picFourBtn: UIButton!
    @IBOutlet weak var picFiveBtn: UIButton!
    @IBOutlet weak var picSixBtn: UIButton!
    @IBOutlet weak var nextBtn: AnimatableButton!
    
    // MARK: - 内部属性
    fileprivate var imageType: ImageType?
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "录入客户信息"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        nextBtn.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth - 32)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 控件点击事件
    
    /// 上传身份证正面
    ///
    /// - Parameter sender: 按钮
    @IBAction func picOneBtnClick(_ sender: UIButton) {
        imageType = ImageType.picOne
        uploadsPic()
    }
    
    /// 上传身份证反面
    ///
    /// - Parameter sender: 按钮
    @IBAction func picTwoBtnClick(_ sender: UIButton) {
        imageType = ImageType.picTwo
        uploadsPic()
    }
    
    /// 上传房产证明
    ///
    /// - Parameter sender: 按钮
    @IBAction func picThreeBtnClick(_ sender: UIButton) {
        imageType = ImageType.picThree
        uploadsPic()
    }
    
    /// 上传车辆登记
    ///
    /// - Parameter sender: 按钮
    @IBAction func picFourBtnClick(_ sender: UIButton) {
        imageType = ImageType.picFour
        uploadsPic()
    }
    
    /// 上传营业执照
    ///
    /// - Parameter sender: 按钮
    @IBAction func picFiveBtnClick(_ sender: UIButton) {
        imageType = ImageType.picFive
        uploadsPic()
    }
    
    /// 上传其他证明
    ///
    /// - Parameter sender: 按钮
    @IBAction func picSixBtnClick(_ sender: UIButton) {
        imageType = ImageType.picSix
        uploadsPic()
    }
    
    /// 下一步
    ///
    /// - Parameter sender: 按钮
    @IBAction func nextBtnClick(_ sender: AnimatableButton) {
        let vc = XinyidaiFinishViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension XinyidaiInfoFourViewController {
    
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
extension XinyidaiInfoFourViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        switch imageType {
        case .picOne?:
            picOneBtn.setImage(image, for: .normal)
        case .picTwo?:
            picTwoBtn.setImage(image, for: .normal)
        case .picThree?:
            picThreeBtn.setImage(image, for: .normal)
        case .picFour?:
            picFourBtn.setImage(image, for: .normal)
        case .picFive?:
            picFiveBtn.setImage(image, for: .normal)
        case .picSix?:
            picSixBtn.setImage(image, for: .normal)
        default:break
        }
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}
